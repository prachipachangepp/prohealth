import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/employeement_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employeement_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/add_employee_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_employeement_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/constant_checkbox/const_checckboxtile.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../icon_button_constant.dart';
import '../../row_container_widget_const.dart';

///done by saloni
class EmploymentContainerConstant extends StatefulWidget {
  @override
  State<EmploymentContainerConstant> createState() => _EmploymentContainerConstantState();
}

class _EmploymentContainerConstantState extends State<EmploymentContainerConstant> {
  final StreamController<List<EmployeementData>> employeementStreamController = StreamController<List<EmployeementData>>();
  TextEditingController positionTitleController = TextEditingController();
  TextEditingController leavingResonController = TextEditingController();
  TextEditingController startDateContoller = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController lastSupervisorNameController = TextEditingController();
  TextEditingController supervisorMobileNumber = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController employeerController = TextEditingController();
  TextEditingController emergencyMobileNumber = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    getEmployeement(context,2).then((data) {
      employeementStreamController.add(data);
    }).catchError((error) {
      // Handle error
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EmployeementData>>(
      stream: employeementStreamController.stream,
      builder: (context,snapshot) {
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
          return WrapWidget(
              childern:List.generate(snapshot.data!.length, (index){
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
                    height: MediaQuery.of(context).size.height/3.3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 80,
                        vertical: MediaQuery.of(context).size.height / 120,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Employment #1',
                            style: TextStyle(
                              fontFamily: 'FiraSans',
                              fontSize: 13,
                              color: Color(0xFF333333),
                              fontWeight: FontWeight.w500,
                            ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Final Position Title',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('Start Date',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('End Date',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('Employer',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('Emergency Contact',
                                      style: ThemeManager.customTextStyle(context)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].title,
                                    style: ThemeManagerDark.customTextStyle(context),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data![index].dateOfJoining,
                                    style: ThemeManagerDark.customTextStyle(context),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data![index].endDate,
                                    style: ThemeManagerDark.customTextStyle(context),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data![index].employer,
                                    style: ThemeManagerDark.customTextStyle(context),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '9845632156',
                                    style: ThemeManagerDark.customTextStyle(context),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Reason of Leaving',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('Last Supervisor’s Name',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('SuperVisor\'s Phone No.',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('City',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('Country',
                                      style: ThemeManager.customTextStyle(context)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].reason,
                                    style: ThemeManagerDark.customTextStyle(context),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data![index].supervisor,
                                    style: ThemeManagerDark.customTextStyle(context),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data![index].supMobile,
                                    style: ThemeManagerDark.customTextStyle(context),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data![index].city,
                                    style: ThemeManagerDark.customTextStyle(context),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Germany',
                                    style: ThemeManagerDark.customTextStyle(context),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height/6,),
                                  IconButtonWidget(
                                      iconData: Icons.edit_outlined,
                                      buttonText: 'Edit',
                                      onPressed: () {
                                        setState(() {
                                          showDialog(context: context, builder: (BuildContext context){
                                            return FutureBuilder<EmployeementPrefillData>(
                                              future: getPrefillEmployeement(context,snapshot.data![index].employmentId),
                                              builder: (context,snapshotPrefill) {
                                                if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                                  return Center(
                                                    child: CircularProgressIndicator(
                                                      color: ColorManager.blueprime,
                                                    ),
                                                  );
                                                }
                                                var positionTitle = snapshotPrefill.data!.title;
                                                positionTitleController = TextEditingController(text: snapshotPrefill.data!.title);

                                                var leavingReason = snapshotPrefill.data!.reason;
                                                leavingResonController = TextEditingController(text: snapshotPrefill.data!.reason);

                                                var startDate = snapshotPrefill.data!.dateOfJoining;
                                                startDateContoller = TextEditingController(text: snapshotPrefill.data!.dateOfJoining);

                                                var endDate = snapshotPrefill.data!.endDate;
                                                endDateController = TextEditingController(text: snapshotPrefill.data!.endDate);

                                                var supervisorName = snapshotPrefill.data!.supervisor;
                                                lastSupervisorNameController = TextEditingController(text: snapshotPrefill.data!.supervisor);

                                                var supervisorMob = snapshotPrefill.data!.supMobile;
                                                supervisorMobileNumber = TextEditingController(text: snapshotPrefill.data!.supMobile);

                                                var cityName = snapshotPrefill.data!.city;
                                                cityNameController = TextEditingController(text: snapshotPrefill.data!.city);

                                                var employeer = snapshotPrefill.data!.employer;
                                                employeerController = TextEditingController(text: snapshotPrefill.data!.employer);


                                                return AddEmployeementPopup(positionTitleController: positionTitleController, leavingResonController: leavingResonController, startDateContoller: startDateContoller,
                                                    endDateController: endDateController, lastSupervisorNameController: lastSupervisorNameController,
                                                    supervisorMobileNumber: supervisorMobileNumber, cityNameController: cityNameController,
                                                    employeerController: employeerController, emergencyMobileNumber: emergencyMobileNumber,
                                                    onpressedClose: (){}, onpressedSave: ()async{
                                                  await updateEmployeementPatch(context,
                                                      snapshot.data![index].employmentId,
                                                      2,
                                                     employeer == employeerController.text ? employeer.toString() : employeerController.text,
                                                      cityName == cityNameController.text ? cityName.toString() : cityNameController.text,
                                                      leavingReason == leavingResonController.text ? leavingReason.toString() : leavingResonController.text,
                                                      supervisorName == lastSupervisorNameController.text ? supervisorName.toString() : lastSupervisorNameController.text,
                                                      supervisorMob == supervisorMobileNumber.text ? supervisorMob.toString() : supervisorMobileNumber.text,
                                                      positionTitle == positionTitleController.text ? positionTitle.toString() : positionTitleController.text,
                                                      startDate == startDateContoller.text ? startDate : startDateContoller.text,
                                                      endDate == endDateController.text ? endDate : endDateController.text);
                                                  getEmployeement(context,2).then((data) {
                                                    employeementStreamController.add(data);
                                                  }).catchError((error) {
                                                    // Handle error
                                                  });
                                                  }, checkBoxTile:  Container(
                                                      width: 300,
                                                      child: CheckboxTile(title: 'Currently work here',initialValue: false,onChanged: (value){
                                                      },)), tite: 'Edit Employeement',);
                                              }
                                            );
                                          });
                                        });


                                      }),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
          );
        }else{
          return SizedBox();
        }

      }
    );


  }
}