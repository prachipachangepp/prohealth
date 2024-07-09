import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/education_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/education_data.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_education_popup.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../icon_button_constant.dart';
import '../../row_container_widget_const.dart';
class EducationChildTabbar extends StatefulWidget {
  const EducationChildTabbar({super.key});

  @override
  State<EducationChildTabbar> createState() => _EducationChildTabbarState();
}

class _EducationChildTabbarState extends State<EducationChildTabbar> {
  final StreamController<List<EducationData>> educationStreamController = StreamController<List<EducationData>>();
  TextEditingController collegeUniversityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController majorSubjectController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  String expiryType = '';
  @override
  void initState() {
    // TODO: implement initState
    getEmployeeEducation(context,2).then((data) {
      educationStreamController.add(data);
    }).catchError((error) {
      // Handle error
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EducationData>>(
      stream: educationStreamController.stream,
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
          return WrapWidget(childern: List.generate(snapshot.data!.length, (index){
            return Padding(
              padding:const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
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
                    horizontal: MediaQuery.of(context).size.width / 120,
                    vertical: MediaQuery.of(context).size.height / 120,
                  ),
                  child: Column(
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
                              Text(snapshot.data![index].degree,
                                style: ThemeManagerDark.customTextStyle(context),),
                              const SizedBox(height: 10,),
                              Text(snapshot.data![index].graduate,
                                style: ThemeManagerDark.customTextStyle(context),),
                              const SizedBox(height: 10,),
                              Text(snapshot.data![index].college,
                                style: ThemeManagerDark.customTextStyle(context),),
                              const SizedBox(height: 10,),
                              Text(snapshot.data![index].major,
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
                              Text(snapshot.data![index].phone,
                                style: ThemeManagerDark.customTextStyle(context),),
                              const SizedBox(height: 10,),
                              Text(snapshot.data![index].city,
                                style: ThemeManagerDark.customTextStyle(context),),
                              const SizedBox(height: 10,),
                              Text(snapshot.data![index].state,
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
                              buttonText: 'Edit', onPressed: (){
                            showDialog(context: context, builder: (BuildContext context){
                              return StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {
                                  return  AddEducationPopup(collegeUniversityController: collegeUniversityController,
                                    phoneController: phoneController,
                                    calenderController: calenderController, cityController: cityController,
                                    degreeController: degreeController, stateController: stateController, majorSubjectController: majorSubjectController,
                                    countryNameController: countryNameController, onpressedClose: (){
                                      Navigator.pop(context);
                                    }, onpressedSave: () async{
                                      await updateEmployeeEducation(context, snapshot.data![index].educationId,2, expiryType.toString(), degreeController.text, majorSubjectController.text, cityController.text,
                                          collegeUniversityController.text, phoneController.text, stateController.text);
                                      getEmployeeEducation(context,2).then((data) {
                                        educationStreamController.add(data);
                                      }).catchError((error) {
                                        // Handle error
                                      });
                                      expiryType = '';
                                    },
                                    radioButton:Container(
                                      width: 280,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CustomRadioListTile(
                                              value: "Yes",
                                              groupValue: expiryType.toString(),
                                              onChanged: (value) {
                                                setState(() {
                                                  expiryType = value!;
                                                });
                                              },
                                              title: "Yes",
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomRadioListTile(
                                              value: "No",
                                              groupValue: expiryType.toString(),
                                              onChanged: (value) {
                                                setState(() {
                                                  expiryType = value!;
                                                });
                                              },
                                              title: "No",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ), title: 'Add Education',);
                                },
                              );
                            });
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }));
        }else{
          return SizedBox();
        }

      }
    );

  }
}