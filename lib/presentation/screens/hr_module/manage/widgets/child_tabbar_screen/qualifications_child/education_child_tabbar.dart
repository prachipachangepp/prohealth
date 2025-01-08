import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/education_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/education_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_education_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/const_card_details.dart';
import 'package:prohealth/presentation/widgets/error_popups/failed_popup.dart';
import 'package:prohealth/presentation/widgets/error_popups/four_not_four_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../icon_button_constant.dart';
import '../../row_container_widget_const.dart';

class EducationChildTabbar extends StatelessWidget {
  final int employeeId;
  const EducationChildTabbar({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    final educationProviderState = Provider.of<HrManageProvider>(context, listen: false);
    final LayerLink _layerLink = LayerLink();
    final StreamController<List<EducationData>> educationStreamController = StreamController<List<EducationData>>();
    TextEditingController collegeUniversityController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController calenderController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController degreeController = TextEditingController();
    TextEditingController stateController = TextEditingController();
    TextEditingController majorSubjectController = TextEditingController();
    TextEditingController countryNameController = TextEditingController();
    String expiryType = 'No';
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///add button
            Container(
              width: 100,
              margin: EdgeInsets.only(right: 60),
              child: CustomIconButtonConst(
                  text: AppStringHr.add,
                  icon: Icons.add,
                  onPressed: () {
                    collegeUniversityController.clear();
                    phoneController.clear();
                    calenderController.clear();
                    cityController.clear();
                    degreeController.clear();
                    stateController.clear();
                    majorSubjectController.clear();
                    countryNameController.clear();
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
                            majorSubjectController: majorSubjectController,
                            countryNameController: countryNameController,
                            onpressedClose: () {

                            },
                            onpressedSave: () async {
                              var response = await addEmployeeEducation(
                                  context,
                                  employeeId,
                                  expiryType.toString(),
                                  degreeController.text,
                                  majorSubjectController.text,
                                  cityController.text,
                                  collegeUniversityController.text,
                                  phoneController.text,
                                  stateController.text,
                                  countryNameController.text,
                                  calenderController.text);
                              var educationResponse = await approveOnboardQualifyEducationPatch(context, response.educationId!);
                              Navigator.pop(context);
                              if(educationResponse.statusCode == 200 || educationResponse.statusCode == 201){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddSuccessPopup(
                                      message: 'Education Added Successfully',
                                    );
                                  },
                                );
                              }else if(response.statusCode == 400 || response.statusCode == 404){
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => const FourNotFourPopup(),
                                );
                              }
                              else {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => FailedPopup(text: response.message),
                                );
                              }
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
            getEmployeeEducation(context,employeeId).then((data) {
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
                  child: Padding(
                    padding:const EdgeInsets.symmetric(vertical: 100),
                    child: Text(
                      AppStringHRNoData.educationNoData,
                      style: AllNoDataAvailable.customTextStyle(context),
                    ),
                  ));
            }
            if(snapshot.hasData){
              return Consumer<HrManageProvider>(
                builder: (context,providerState,child) {
                  return WrapWidget(
                      children: List.generate(snapshot.data!.length, (index){
                        providerState.trimDegreeString(snapshot.data![index].degree);
                        providerState.trimCollegeString(snapshot.data![index].college);
                        providerState.trimMajorString(snapshot.data![index].major);
                    return CardDetails(childWidget: DetailsFormate(
                      title:  'Education #${index + 1}',
                        row1Child1:  [
                          Text('Degree :',
                              style: ThemeManagerDark.customTextStyle(context)),
                          const SizedBox(height: AppSize.s10,),
                          Text('Graduate :',
                              style: ThemeManagerDark.customTextStyle(context)),
                          const SizedBox(height: AppSize.s10),
                          Text('Educational Institute :',
                              style: ThemeManagerDark.customTextStyle(context)),
                          const SizedBox(height: AppSize.s10),
                          Text('Major Subject :',
                              style: ThemeManagerDark.customTextStyle(context)),
                        ],
                        row1Child2: [
                          MouseRegion(
                            onHover: (event){
                              educationProviderState.showOverlay(context, event.position, snapshot.data![index].degree ?? '--');
                            },
                            onExit: (_) {
                              // Remove overlay when the cursor exits the widget
                              educationProviderState.removeOverlay();
                            },
                            child: CompositedTransformTarget(link: _layerLink,
                              child: Text(
                                educationProviderState.trimmedDegree,
                                style: ThemeManagerDarkFont.customTextStyle(context),
                              ),),
                          ),
                          // Text(snapshot.data![index].degree,
                          //   style: ThemeManagerDarkFont.customTextStyle(context),),
                          const SizedBox(height: AppSize.s10,),
                          Text(snapshot.data![index].graduate,
                            style: ThemeManagerDarkFont.customTextStyle(context),),
                          const SizedBox(height: AppSize.s10,),
                         MouseRegion(
                          onHover: (event){
                            educationProviderState.showOverlay(context, event.position, snapshot.data![index].college ?? '--');
                          },
                          onExit: (_) {
                            // Remove overlay when the cursor exits the widget
                            educationProviderState.removeOverlay();
                          },
                          child: CompositedTransformTarget(link: _layerLink,
                          child: Text(
                            educationProviderState.trimmedCollege,
                                style: ThemeManagerDarkFont.customTextStyle(context),
                              ),),
                        ),
                        // MouseRegion(
                        //   onEnter: (event) {
                        //     RenderBox box = context.findRenderObject() as RenderBox;
                        //     Offset position = box.localToGlobal(Offset.zero);
                        //     _showOverlayAddress(context, position, snapshot.data![index].college ?? '--');
                        //   },
                        //   onExit: (_) {
                        //     _removeOverlayAddress();
                        //   },
                        //   child: Text(
                        //     _trimAddress(snapshot.data![index].college ?? '--'),
                        //     style: ThemeManagerDarkFont.customTextStyle(context),
                        //   ),
                        // ),
                        ///plain text
                        // Text(_trimAddress(snapshot.data![index].college),
                        //     style: ThemeManagerDarkFont.customTextStyle(context),),
                          const SizedBox(height: AppSize.s10),
                          Text(educationProviderState.trimmedMajor,
                            style: ThemeManagerDarkFont.customTextStyle(context),),
                        ],
                        row2Child1: [
                          Text('Phone :',
                              style: ThemeManagerDark.customTextStyle(context)),
                          const SizedBox(height: AppSize.s10,),
                          Text("City :",
                              style: ThemeManagerDark.customTextStyle(context)),
                          const SizedBox(height: AppSize.s10),
                          Text("State :",
                              style: ThemeManagerDark.customTextStyle(context)),
                          const SizedBox(height: AppSize.s10),
                          Text("Country :",
                              style: ThemeManagerDark.customTextStyle(context)),
                        ],
                        row2Child2: [
                          Text(snapshot.data![index].phone,
                            style: ThemeManagerDarkFont.customTextStyle(context),),
                          const SizedBox(height: AppSize.s10),
                          Text(snapshot.data![index].city,
                            style: ThemeManagerDarkFont.customTextStyle(context),),
                          const SizedBox(height: AppSize.s10),
                          Text(snapshot.data![index].state,
                              style: ThemeManagerDarkFont.customTextStyle(context)),
                          const SizedBox(height: AppSize.s10),
                          Text(snapshot.data![index].country,
                              style: ThemeManagerDarkFont.customTextStyle(context)),
                        ],
                        button: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            snapshot.data![index].approved == null ?
                            SizedBox(
                              height: 25,
                            ):
                          BorderIconButton(iconData: Icons.edit_outlined,
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

                                        var country = snapshotPrefill.data!.country;
                                        countryNameController = TextEditingController(text: snapshotPrefill.data!.country);

                                        var startDate = snapshotPrefill.data!.startDate;
                                        calenderController = TextEditingController(text: snapshotPrefill.data!.startDate);
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
                                                var response = await updateEmployeeEducation(context,
                                                  snapshot.data![index].educationId,
                                                  employeeId,
                                                  graduate == expiryType.toString() ? graduate.toString() : expiryType.toString(),
                                                  degree == degreeController.text ? degree.toString() : degreeController.text,
                                                  majorSubject == majorSubjectController.text ? majorSubject.toString() : majorSubjectController.text,
                                                  city == cityController.text ? city.toString() : cityController.text,
                                                  college == collegeUniversityController.text ? college.toString() : collegeUniversityController.text,
                                                  phone == phoneController.text ? phone.toString() : phoneController.text,
                                                  state == stateController.text ? state.toString() : stateController.text,
                                                  country == countryNameController.text ?  country.toString() : countryNameController.text,
                                                  startDate == calenderController.text ? startDate : calenderController.text,
                                                );
                                                Navigator.pop(context);
                                                if(response.statusCode == 200 || response.statusCode == 201){
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AddSuccessPopup(
                                                        message: 'Education Edit Successfully',
                                                      );
                                                    },
                                                  );
                                                }else if(response.statusCode == 400 || response.statusCode == 404){
                                                  Navigator.pop(context);
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) => const FourNotFourPopup(),
                                                  );
                                                }
                                                else {
                                                  Navigator.pop(context);
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) => FailedPopup(text: response.message),
                                                  );
                                                }
                                                expiryType = '';
                                              },
                                              radioButton:Container(
                                                width: AppSize.s280,
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
                        )),);
                  }));
                }
              );
            }else{
              return SizedBox();
            }

          }
        ),
      ],
    );

  }
}

//   Padding(
//   padding:const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
//   child: Container(
//     width: MediaQuery.of(context).size.width/2.5,
//     padding: EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.5),
//           spreadRadius: 1,
//           blurRadius: 4,
//           offset: Offset(0, 4),
//         ),
//       ],
//       color: Colors.white,
//       borderRadius: BorderRadius.all(Radius.circular(12)),
//     ),
//     // height:  MediaQuery.of(context).size.height/3.3,
//     height: MediaQuery.of(context).size.height/3.8,
//     child: Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width / 120,
//         vertical: MediaQuery.of(context).size.height / 120,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//            Row(children: [
//              Text(
//
//                'Education #${index + 1}',
//                // 'Education #${snapshot.data![index].educationId}',
//                style: BoxHeadingStyle.customTextStyle(context)),
//           ],),
//           SizedBox(height: MediaQuery.of(context).size.height/50,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Degree :',
//                       style: ThemeManagerDark.customTextStyle(context)),
//                   const SizedBox(height: AppSize.s10,),
//                   Text('Graduate :',
//                       style: ThemeManagerDark.customTextStyle(context)),
//                   const SizedBox(height: AppSize.s10),
//                   Text('Educational Institute :',
//                       style: ThemeManagerDark.customTextStyle(context)),
//                   const SizedBox(height: AppSize.s10),
//                   Text('Major Subject :',
//                       style: ThemeManagerDark.customTextStyle(context)),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(snapshot.data![index].degree,
//                     style: ThemeManagerDarkFont.customTextStyle(context),),
//                   const SizedBox(height: AppSize.s10,),
//                   Text(snapshot.data![index].graduate,
//                     style: ThemeManagerDarkFont.customTextStyle(context),),
//                   const SizedBox(height: AppSize.s10,),
//                   Text(snapshot.data![index].college,
//                     style: ThemeManagerDarkFont.customTextStyle(context),),
//                   const SizedBox(height: AppSize.s10),
//                   Text(snapshot.data![index].major,
//                     style: ThemeManagerDarkFont.customTextStyle(context),),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text('Phone :',
//                       style: ThemeManagerDark.customTextStyle(context)),
//                   const SizedBox(height: AppSize.s10,),
//                   Text("City :",
//                       style: ThemeManagerDark.customTextStyle(context)),
//                   const SizedBox(height: AppSize.s10),
//                   Text("State :",
//                       style: ThemeManagerDark.customTextStyle(context)),
//                   const SizedBox(height: AppSize.s10),
//                   Text("Country :",
//                       style: ThemeManagerDark.customTextStyle(context)),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(snapshot.data![index].phone,
//                     style: ThemeManagerDarkFont.customTextStyle(context),),
//                   const SizedBox(height: AppSize.s10),
//                   Text(snapshot.data![index].city,
//                     style: ThemeManagerDarkFont.customTextStyle(context),),
//                   const SizedBox(height: AppSize.s10),
//                   Text(snapshot.data![index].state,
//                       style: ThemeManagerDarkFont.customTextStyle(context)),
//                   const SizedBox(height: AppSize.s10),
//                   Text(snapshot.data![index].country,
//                       style: ThemeManagerDarkFont.customTextStyle(context)),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height/40,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [snapshot.data![index].approved == null ? Text('Not Approved',style:GoogleFonts.firaSans(
//               fontSize: MediaQuery.of(context).size.width/120,
//               color: ColorManager.mediumgrey,
//               fontWeight: FontWeight.w600,
//             )):
//             BorderIconButton(iconData: Icons.edit_outlined,
//                   buttonText: 'Edit', onPressed: (){
//                 showDialog(context: context, builder: (BuildContext context){
//                   return FutureBuilder<EducationPrefillData>(
//                     future: getPrefillEmployeeEducation(context,snapshot.data![index].educationId),
//                     builder: (context, snapshotPrefill) {
//                       if(snapshotPrefill.connectionState == ConnectionState.waiting){
//                         return Center(
//                           child: CircularProgressIndicator(
//                             color: ColorManager.blueprime,
//                           ),
//                         );
//                       }
//                       var college = snapshotPrefill.data!.college;
//                       collegeUniversityController = TextEditingController(text: snapshotPrefill.data!.college);
//
//                       var phone = snapshotPrefill.data!.phone;
//                       phoneController = TextEditingController(text: snapshotPrefill.data!.phone);
//
//                       var city = snapshotPrefill.data!.city;
//                       cityController = TextEditingController(text: snapshotPrefill.data!.city);
//
//                       var degree = snapshotPrefill.data!.degree;
//                       degreeController = TextEditingController(text: snapshotPrefill.data!.degree);
//
//                       var state = snapshotPrefill.data!.state;
//                       stateController = TextEditingController(text: snapshotPrefill.data!.state);
//
//                       var majorSubject = snapshotPrefill.data!.major;
//                       majorSubjectController = TextEditingController(text: snapshotPrefill.data!.major);
//
//                       var graduate = snapshotPrefill.data!.graduate;
//                       expiryType = snapshotPrefill.data!.graduate.toString();
//
//                       var country = snapshotPrefill.data!.country;
//                       countryNameController = TextEditingController(text: snapshotPrefill.data!.country);
//
//                       var startDate = snapshotPrefill.data!.startDate;
//                       calenderController = TextEditingController(text: snapshotPrefill.data!.startDate);
//                       //countryNameController = TextEditingController(text: "")
//
//                       return StatefulBuilder(
//                         builder: (BuildContext context, void Function(void Function()) setState) {
//                           return  AddEducationPopup(collegeUniversityController: collegeUniversityController,
//                             phoneController: phoneController,
//                             calenderController: calenderController, cityController: cityController,
//                             degreeController: degreeController, stateController: stateController, majorSubjectController: majorSubjectController,
//                             countryNameController: countryNameController, onpressedClose: (){
//                               Navigator.pop(context);
//                             }, onpressedSave: () async{
//                               await updateEmployeeEducation(context,
//                                   snapshot.data![index].educationId,
//                                   widget.employeeId,
//                                  graduate == expiryType.toString() ? graduate.toString() : expiryType.toString(),
//                                   degree == degreeController.text ? degree.toString() : degreeController.text,
//                                  majorSubject == majorSubjectController.text ? majorSubject.toString() : majorSubjectController.text,
//                                   city == cityController.text ? city.toString() : cityController.text,
//                                   college == collegeUniversityController.text ? college.toString() : collegeUniversityController.text,
//                                   phone == phoneController.text ? phone.toString() : phoneController.text,
//                                   state == stateController.text ? state.toString() : stateController.text,
//                                   country == countryNameController.text ?  country.toString() : countryNameController.text,
//                                   startDate == calenderController.text ? startDate : calenderController.text,
//                                   );
//                               expiryType = '';
//                             },
//                             radioButton:Container(
//                               width: AppSize.s280,
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: CustomRadioListTile(
//                                       value: "Yes",
//                                       groupValue: expiryType.toString(),
//                                       onChanged: (value) {
//                                         setState(() {
//                                           expiryType = value!;
//                                         });
//                                       },
//                                       title: "Yes",
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: CustomRadioListTile(
//                                       value: "No",
//                                       groupValue: expiryType.toString(),
//                                       onChanged: (value) {
//                                         setState(() {
//                                           expiryType = value!;
//                                         });
//                                       },
//                                       title: "No",
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ), title: 'Edit Education',);
//                         },
//                       );
//                     }
//                   );
//                 });
//                   })
//             ],
//           )
//         ],
//       ),
//     ),
//   ),
// );