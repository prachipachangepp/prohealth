import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/education_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/education_data.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_education_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../icon_button_constant.dart';
import '../../row_container_widget_const.dart';
class EducationChildTabbar extends StatefulWidget {
  final int employeeId;
  const EducationChildTabbar({super.key, required this.employeeId});

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


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 100,
              margin: EdgeInsets.only(right: 20),
              child: CustomIconButtonConst(
                  text: AppStringHr.add,
                  icon: Icons.add,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AddEducationPopup(
                            collegeUniversityController:
                            collegeUniversityController,
                            phoneController: phoneController,
                            calenderController: calenderController,
                            cityController: cityController,
                            degreeController: degreeController,
                            stateController: stateController,
                            majorSubjectController:
                            majorSubjectController,
                            countryNameController:
                            countryNameController,
                            onpressedClose: () {
                              Navigator.pop(context);
                            },
                            onpressedSave: () async {
                              await addEmployeeEducation(
                                  context,
                                  widget.employeeId!,
                                  expiryType.toString(),
                                  degreeController.text,
                                  majorSubjectController.text,
                                  cityController.text,
                                  collegeUniversityController.text,
                                  phoneController.text,
                                  stateController.text);
                            },
                            radioButton: StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                return Container(
                                  width: 280,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomRadioListTile(
                                          value: "Yes",
                                          groupValue:
                                          expiryType.toString(),
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
                                          groupValue:
                                          expiryType.toString(),
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
                                );
                              },
                            ),
                            title: 'Add Education',
                          );
                        });
                  }),
            ),
          ],
        ),
        StreamBuilder<List<EducationData>>(
          stream: educationStreamController.stream,
          builder: (context,snapshot) {
            getEmployeeEducation(context,widget.employeeId).then((data) {
              educationStreamController.add(data);
            }).catchError((error) {
              // Handle error
            });
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Padding(
                  padding:const EdgeInsets.symmetric(vertical: 100),
                  child: CircularProgressIndicator(
                    color: ColorManager.blueprime,
                  ),
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
                    height:  MediaQuery.of(context).size.height/3.3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 120,
                        vertical: MediaQuery.of(context).size.height / 120,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Row(children: [
                            Text('Education #${snapshot.data![index].educationId}',
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
                                  return FutureBuilder<EducationPrefillData>(
                                    future: getPrefillEmployeeEducation(context,snapshot.data![index].educationId),
                                    builder: (context, snapshotPrefill) {
                                      if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: ColorManager.blueprime,
                                          ),
                                        );
                                      }
                                      var college = snapshotPrefill.data!.college;
                                      collegeUniversityController = TextEditingController(text: snapshotPrefill.data!.college);

                                      var phone = snapshotPrefill.data!.phone;
                                      phoneController = TextEditingController(text: snapshotPrefill.data!.phone);

                                      var city = snapshotPrefill.data!.city;
                                      cityController = TextEditingController(text: snapshotPrefill.data!.city);

                                      var degree = snapshotPrefill.data!.degree;
                                      degreeController = TextEditingController(text: snapshotPrefill.data!.degree);

                                      var state = snapshotPrefill.data!.state;
                                      stateController = TextEditingController(text: snapshotPrefill.data!.state);

                                      var majorSubject = snapshotPrefill.data!.major;
                                      majorSubjectController = TextEditingController(text: snapshotPrefill.data!.major);

                                      var graduate = snapshotPrefill.data!.graduate;
                                      expiryType = snapshotPrefill.data!.graduate.toString();
                                      //countryNameController = TextEditingController(text: "")

                                      return StatefulBuilder(
                                        builder: (BuildContext context, void Function(void Function()) setState) {
                                          return  AddEducationPopup(collegeUniversityController: collegeUniversityController,
                                            phoneController: phoneController,
                                            calenderController: calenderController, cityController: cityController,
                                            degreeController: degreeController, stateController: stateController, majorSubjectController: majorSubjectController,
                                            countryNameController: countryNameController, onpressedClose: (){
                                              Navigator.pop(context);
                                            }, onpressedSave: () async{
                                              await updateEmployeeEducation(context,
                                                  snapshot.data![index].educationId,
                                                  widget.employeeId,
                                                 graduate == expiryType.toString() ? graduate.toString() : expiryType.toString(),
                                                  degree == degreeController.text ? degree.toString() : degreeController.text,
                                                 majorSubject == majorSubjectController.text ? majorSubject.toString() : majorSubjectController.text,
                                                  city == cityController.text ? city.toString() : cityController.text,
                                                  college == collegeUniversityController.text ? college.toString() : collegeUniversityController.text,
                                                  phone == phoneController.text ? phone.toString() : phoneController.text,
                                                  state == stateController.text ? state.toString() : stateController.text);
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
                                            ), title: 'Edit Education',);
                                        },
                                      );
                                    }
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
        ),
      ],
    );

  }
}