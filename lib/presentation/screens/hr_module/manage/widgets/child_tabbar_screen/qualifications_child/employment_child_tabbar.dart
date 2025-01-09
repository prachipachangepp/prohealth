import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/employeement_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import 'package:prohealth/app/services/api/managers/post_html_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employeement_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/add_employee_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_employeement_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/const_card_details.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/constant_widgets/const_checckboxtile.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import 'package:prohealth/presentation/widgets/error_popups/failed_popup.dart';
import 'package:prohealth/presentation/widgets/error_popups/four_not_four_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../icon_button_constant.dart';
import '../../row_container_widget_const.dart';

///done by saloni
class EmploymentContainerConstant extends StatelessWidget {
  final int employeeId;
  EmploymentContainerConstant({required this.employeeId});
  @override
  Widget build(BuildContext context) {
    final employeementProviderState = Provider.of<HrManageProvider>(
        context, listen: false);
    bool isSelectedADD = false;
    bool isSelectedEdit = false;
    final LayerLink _layerLink = LayerLink();
    int currentPage = 0;
    int itemsPerPage = 0;
    final StreamController<
        List<EmployeementData>> employeementStreamController = StreamController<
        List<EmployeementData>>();
    TextEditingController positionTitleController = TextEditingController();
    TextEditingController leavingResonController = TextEditingController();
    TextEditingController startDateContoller = TextEditingController();
    TextEditingController endDateController = TextEditingController();
    TextEditingController lastSupervisorNameController = TextEditingController();
    TextEditingController supervisorMobileNumber = TextEditingController();
    TextEditingController cityNameController = TextEditingController();
    TextEditingController employeerController = TextEditingController();
    TextEditingController emergencyMobileNumber = TextEditingController();
    TextEditingController countryController = TextEditingController();
    //print("Employee id in EmployeeMent screen :: ${employeeId}");
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
                    positionTitleController.clear();
                    leavingResonController.clear();
                    startDateContoller.clear();
                    endDateController.clear();
                    lastSupervisorNameController.clear();
                    supervisorMobileNumber.clear();
                    cityNameController.clear();
                    employeerController.clear();
                    emergencyMobileNumber.clear();
                    countryController.clear();
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      // routeSettings: ,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return AddEmployeementPopup(
                              positionTitleController: positionTitleController,
                              leavingResonController: leavingResonController,
                              startDateContoller: startDateContoller,
                              endDateController: endDateController,
                              lastSupervisorNameController: lastSupervisorNameController,
                              supervisorMobileNumber: supervisorMobileNumber,
                              cityNameController: cityNameController,
                              employeerController: employeerController,
                              emergencyMobileNumber: emergencyMobileNumber,
                              countryController: countryController,

                              onpressedSave: () async {
                                var response = await addEmployeement(
                                    context,
                                    employeeId,
                                    employeerController.text,
                                    cityNameController.text,
                                    leavingResonController.text,
                                    lastSupervisorNameController.text,
                                    supervisorMobileNumber.text,
                                    positionTitleController.text,
                                    startDateContoller.text,
                                    isSelectedADD
                                        ? "Currently Working"
                                        : endDateController.text,
                                    emergencyMobileNumber.text,
                                    countryController.text);

                                var approveResponse = await approveOnboardQualifyEmploymentPatch(
                                    context, response.employeementId!);
                                if (approveResponse.statusCode == 200 ||
                                    approveResponse.statusCode == 201) {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddSuccessPopup(
                                        message: 'Employement Added Successfully',
                                      );
                                    },
                                  );
                                } else if (response.statusCode == 400 ||
                                    response.statusCode == 404) {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (
                                        BuildContext context) => const FourNotFourPopup(),
                                  );
                                }
                                else {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        FailedPopup(text: response.message),
                                  );
                                }
                              },
                              checkBoxTile: StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return Container(
                                    //color: Colors.red,
                                      width: 300,
                                      child: CheckboxTile(
                                        title: 'Currently work here',
                                        initialValue: isSelectedADD,
                                        onChanged: (value) {
                                          setState(() {
                                            isSelectedADD = !isSelectedADD;
                                            endDateController.clear();
                                          });
                                        },
                                      ));
                                },
                              ),
                              tite: 'Add Employment',
                              onpressedClose: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
        StreamBuilder<List<EmployeementData>>(
            stream: employeementStreamController.stream,
            builder: (context, snapshot) {
              getEmployeement(context, employeeId).then((data) {
                employeementStreamController.add(data);
              }).catchError((error) {
                // Handle error
              });
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: CircularProgressIndicator(
                      color: ColorManager.blueprime,
                    ),
                  ),
                );
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Text(
                        AppStringHRNoData.employeeNoData,
                        style: AllNoDataAvailable.customTextStyle(context),
                      ),
                    ));
              }
              if (snapshot.hasData) {
                int totalItems = snapshot.data!.length;
                List<EmployeementData> currentPageItems = snapshot.data!
                    .sublist(
                  (currentPage - 1) * itemsPerPage,
                  (currentPage * itemsPerPage) > totalItems
                      ? totalItems
                      : (currentPage * itemsPerPage),
                );

                return WrapWidget(
                    children: List.generate(snapshot.data!.length, (index) {
                      var fileUrl = snapshot.data![index].documentUrl;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        employeementProviderState.trimEmpAddress(
                            snapshot.data![index].reason);
                        employeementProviderState.trimSupervisor(
                            snapshot.data![index].supervisor);
                      });

                      return CardDetails(
                          childWidget: DetailsFormate(
                            row1Child1: [
                              SizedBox(height: 5,),
                              Text('Final Position Title :',
                                  style: ThemeManagerDark.customTextStyle(
                                      context)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Start Date :',
                                  style: ThemeManagerDark.customTextStyle(
                                      context)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('End Date :',
                                  style: ThemeManagerDark.customTextStyle(
                                      context)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Employer :',
                                  style: ThemeManagerDark.customTextStyle(
                                      context)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Emergency Contact :',
                                  style: ThemeManagerDark.customTextStyle(
                                      context)),
                            ],
                            row1Child2: [
                              SizedBox(height: 5,),
                              Text(
                                snapshot.data![index].title,
                                style: ThemeManagerDarkFont.customTextStyle(
                                    context),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data![index].dateOfJoining,
                                style: ThemeManagerDarkFont.customTextStyle(
                                    context),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data![index].endDate,
                                style: ThemeManagerDarkFont.customTextStyle(
                                    context),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data![index].employer,
                                style: ThemeManagerDarkFont.customTextStyle(
                                    context),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data![index].emgMobile,
                                style: ThemeManagerDarkFont.customTextStyle(
                                    context),
                              ),
                            ],
                            row2Child1: [
                              SizedBox(height: 5,),
                              Text('Reason of Leaving :',
                                  style: ThemeManagerDark.customTextStyle(
                                      context)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Last Supervisor’s Name :',
                                  style: ThemeManagerDark.customTextStyle(
                                      context)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Supervisor\'s Phone No. :',
                                  style: ThemeManagerDark.customTextStyle(
                                      context)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('City :',
                                  style: ThemeManagerDark.customTextStyle(
                                      context)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Country :',
                                  style: ThemeManagerDark.customTextStyle(
                                      context)),
                            ],
                            row2Child2: [
                              SizedBox(height: 5,),
                              MouseRegion(
                                onHover: (event) {
                                  employeementProviderState.showOverlay(
                                      context, event.position,
                                      snapshot.data![index].reason ?? '--');
                                },
                                onExit: (_) {
                                  employeementProviderState.removeOverlay();
                                },
                                child: CompositedTransformTarget(
                                  link: _layerLink,
                                  child: Text(
                                    employeementProviderState
                                        .trimmedEmployeeAddress,
                                    style: ThemeManagerDarkFont.customTextStyle(
                                        context),
                                  ),),
                              ),
                              // Text(_trimAddress(
                              //   snapshot.data![index].reason),
                              //   style: ThemeManagerDarkFont.customTextStyle(context),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              MouseRegion(
                                onHover: (event) {
                                  employeementProviderState.showOverlay(
                                      context, event.position,
                                      snapshot.data![index].supervisor ?? '--');
                                },
                                onExit: (_) {
                                  employeementProviderState.removeOverlay();
                                },
                                child: CompositedTransformTarget(
                                  link: _layerLink,
                                  child: Text(
                                    employeementProviderState.trimmedSupervisor,
                                    style: ThemeManagerDarkFont.customTextStyle(
                                        context),
                                  ),),
                              ),
                              // Text( _trimAddress(
                              //   snapshot.data![index].supervisor),
                              //   style: ThemeManagerDarkFont.customTextStyle(context),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data![index].supMobile,
                                style: ThemeManagerDarkFont.customTextStyle(
                                    context),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data![index].city,
                                style: ThemeManagerDarkFont.customTextStyle(
                                    context),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data![index].country,
                                style: ThemeManagerDarkFont.customTextStyle(
                                    context),
                              ),
                            ],
                            button: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                fileUrl == "--" ? SizedBox(
                                  height: 25,
                                ) : BorderIconButton(
                                  iconData: Icons.remove_red_eye_outlined,
                                  buttonText: 'View',
                                  onPressed: () {
                                    downloadFile(fileUrl);
                                  },),
                                SizedBox(width: 10,),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: snapshot.data![index].approved ==
                                        null ? Text('', style: TextStyle(
                                      fontSize: 12,
                                      color: ColorManager.mediumgrey,
                                      fontWeight: FontWeight.w600,
                                    )) : BorderIconButton(
                                      iconData: Icons.edit_outlined,
                                      buttonText: 'Edit',
                                      onPressed: () {
//                                 setState(() {
//                                   showDialog(context: context, builder: (BuildContext context){
//                                     return FutureBuilder<EmployeementPrefillData>(
//                                         future: getPrefillEmployeement(context,snapshot.data![index].employmentId),
//                                         builder: (context,snapshotPrefill) {
//                                           if(snapshotPrefill.connectionState == ConnectionState.waiting){
//                                             return Center(
//                                               child: CircularProgressIndicator(
//                                                 color: ColorManager.blueprime,
//                                               ),
//                                             );
//                                           }
//                                           var positionTitle = snapshotPrefill.data!.title;
//                                           positionTitleController = TextEditingController(text: snapshotPrefill.data!.title);
//
//                                           var leavingReason = snapshotPrefill.data!.reason;
//                                           leavingResonController = TextEditingController(text: snapshotPrefill.data!.reason);
//
//                                           var startDate = snapshotPrefill.data!.dateOfJoining;
//                                           startDateContoller = TextEditingController(text: snapshotPrefill.data?.dateOfJoining);
//
//                                           var endDate = snapshotPrefill.data!.endDate;
//                                           endDateController = TextEditingController(text: snapshotPrefill.data?.endDate);
//
//
//                                           var supervisorName = snapshotPrefill.data!.supervisor;
//                                           lastSupervisorNameController = TextEditingController(text: snapshotPrefill.data!.supervisor);
//
//                                           var supervisorMob = snapshotPrefill.data!.supMobile;
//                                           supervisorMobileNumber = TextEditingController(text: snapshotPrefill.data!.supMobile);
//
//                                           var cityName = snapshotPrefill.data!.city;
//                                           cityNameController = TextEditingController(text: snapshotPrefill.data!.city);
//
//                                           var employeer = snapshotPrefill.data!.employer;
//                                           employeerController = TextEditingController(text: snapshotPrefill.data!.employer);
//
//                                           var emgMobile = snapshotPrefill.data!.emgMobile;
//                                           emergencyMobileNumber = TextEditingController(text: snapshotPrefill.data!.emgMobile);
//                                           var country = snapshotPrefill.data!.country;
//                                           countryController =TextEditingController(text: snapshotPrefill.data!.country);
//                                           return AddEmployeementPopup(positionTitleController: positionTitleController, leavingResonController: leavingResonController, startDateContoller: startDateContoller,
//                                             endDateController: endDateController, lastSupervisorNameController: lastSupervisorNameController,
//                                             supervisorMobileNumber: supervisorMobileNumber, cityNameController: cityNameController,
//                                             employeerController: employeerController, emergencyMobileNumber: emergencyMobileNumber,
//                                             countryController: countryController,
//                                             onpressedSave: ()async{
//                                               var response = await updateEmployeementPatch(context,
//                                                   snapshot.data![index].employmentId,
//                                                   widget.employeeId,
//                                                   employeer == employeerController.text ? employeer.toString() : employeerController.text,
//                                                   cityName == cityNameController.text ? cityName.toString() : cityNameController.text,
//                                                   leavingReason == leavingResonController.text ? leavingReason.toString() : leavingResonController.text,
//                                                   supervisorName == lastSupervisorNameController.text ? supervisorName.toString() : lastSupervisorNameController.text,
//                                                   supervisorMob == supervisorMobileNumber.text ? supervisorMob.toString() : supervisorMobileNumber.text,
//                                                   positionTitle == positionTitleController.text ? positionTitle.toString() : positionTitleController.text,
//                                                   startDate == startDateContoller.text ? startDate  : startDateContoller.text,
//                                               // isSelectedEdit
//                                                   //     ? null // If currently working, don't update the end date
//                                                   //     : endDate == endDateController.text
//                                                   //     ? endDate
//                                                   //     : endDateController.text,
//                                                   isSelectedEdit ?  "Currently Working" : endDateController.text ,
// //endDate == endDateController.text ? endDate : endDateController.text,
//                                                   emgMobile == emergencyMobileNumber.text ? emgMobile : emergencyMobileNumber.text,
//                                                   country== countryController.text ?country.toString():countryController.text
//                                                 // 'USA'
//                                               );
//                                               if(response.statusCode == 200 || response.statusCode == 201){
//                                                 Navigator.pop(context);
//                                                  showDialog(
//                                                   context: context,
//                                                   builder: (BuildContext context) {
//                                                     return AddSuccessPopup(
//                                                       message: 'Employement Edited Successfully',
//                                                     );
//                                                   },
//                                                 );
//                                               }else if(response.statusCode == 400 || response.statusCode == 404){
//                                                 Navigator.pop(context);
//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (BuildContext context) => const FourNotFourPopup(),
//                                                 );
//                                               }
//                                               else {
//                                                 Navigator.pop(context);
//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (BuildContext context) => FailedPopup(text: response.message),
//                                                 );
//                                               }
//                                          }, checkBoxTile: StatefulBuilder(
//                                                 builder: (BuildContext context, void Function(void Function()) setState) {
//                                                   return Container(
//                                                     //color: Colors.red,
//                                                       width: 300,
//                                                       child: CheckboxTile(
//                                                         title: 'Currently work here',
//                                                         initialValue: isSelectedEdit,
//                                                         onChanged: (value) {
//                                                           setState((){
//                                                             isSelectedEdit = !isSelectedEdit;
//                                                             endDateController.clear();
//                                                           });
//                                                         },
//                                                       ));
//                                                 },
//                                               ),
//                                             // checkBoxTile:  Container(
//                                             //     width: 300,
//                                             //     child: CheckboxTile(title: 'Currently work here',
//                                             //       initialValue: false,onChanged: (value){
//                                             //     },)),
//                                             tite: 'Edit Employment',
//                                             onpressedClose: ()
//                                              {
//                                               Navigator.pop(context);
//                                               },);
//                                         }
//                                     );
//                                   });
//                                 }
                                        showDialog(context: context,
                                            builder: (BuildContext context) {
                                              return FutureBuilder<
                                                  EmployeementPrefillData>(
                                                future: getPrefillEmployeement(
                                                    context,
                                                    snapshot.data![index]
                                                        .employmentId),
                                                builder: (context,
                                                    snapshotPrefill) {
                                                  if (snapshotPrefill
                                                      .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                      child: CircularProgressIndicator(
                                                        color: ColorManager
                                                            .blueprime,
                                                      ),
                                                    );
                                                  }

                                                  var positionTitle = snapshotPrefill
                                                      .data!.title;
                                                  positionTitleController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!.title);

                                                  var leavingReason = snapshotPrefill
                                                      .data!.reason;
                                                  leavingResonController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!.reason);

                                                  var startDate = snapshotPrefill
                                                      .data!.dateOfJoining;
                                                  startDateContoller =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data
                                                              ?.dateOfJoining);

                                                  var endDate = snapshotPrefill
                                                      .data!.endDate;
                                                  endDateController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data?.endDate);

                                                  // Determine the value of isSelectedEdit based on endDateController's value
                                                  if (endDateController.text ==
                                                      "Currently Working") {
                                                    isSelectedEdit = true;
                                                  } else
                                                  if (endDateController.text ==
                                                      "2024/12/24") {
                                                    isSelectedEdit = false;
                                                  }

                                                  var supervisorName = snapshotPrefill
                                                      .data!.supervisor;
                                                  lastSupervisorNameController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!
                                                              .supervisor);

                                                  var supervisorMob = snapshotPrefill
                                                      .data!.supMobile;
                                                  supervisorMobileNumber =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!.supMobile);

                                                  var cityName = snapshotPrefill
                                                      .data!.city;
                                                  cityNameController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!.city);

                                                  var employeer = snapshotPrefill
                                                      .data!.employer;
                                                  employeerController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!.employer);

                                                  var emgMobile = snapshotPrefill
                                                      .data!.emgMobile;
                                                  emergencyMobileNumber =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!.emgMobile);

                                                  var country = snapshotPrefill
                                                      .data!.country;
                                                  countryController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!.country);

                                                  return AddEmployeementPopup(
                                                    positionTitleController: positionTitleController,
                                                    leavingResonController: leavingResonController,
                                                    startDateContoller: startDateContoller,
                                                    endDateController: endDateController,
                                                    lastSupervisorNameController: lastSupervisorNameController,
                                                    supervisorMobileNumber: supervisorMobileNumber,
                                                    cityNameController: cityNameController,
                                                    employeerController: employeerController,
                                                    emergencyMobileNumber: emergencyMobileNumber,
                                                    countryController: countryController,
                                                    onpressedSave: () async {
                                                      var response = await updateEmployeementPatch(
                                                        context,
                                                        snapshot.data![index]
                                                            .employmentId,
                                                        employeeId,
                                                        employeer ==
                                                            employeerController
                                                                .text
                                                            ? employeer
                                                            .toString()
                                                            : employeerController
                                                            .text,
                                                        cityName ==
                                                            cityNameController
                                                                .text
                                                            ? cityName
                                                            .toString()
                                                            : cityNameController
                                                            .text,
                                                        leavingReason ==
                                                            leavingResonController
                                                                .text
                                                            ? leavingReason
                                                            .toString()
                                                            : leavingResonController
                                                            .text,
                                                        supervisorName ==
                                                            lastSupervisorNameController
                                                                .text
                                                            ? supervisorName
                                                            .toString()
                                                            : lastSupervisorNameController
                                                            .text,
                                                        supervisorMob ==
                                                            supervisorMobileNumber
                                                                .text
                                                            ? supervisorMob
                                                            .toString()
                                                            : supervisorMobileNumber
                                                            .text,
                                                        positionTitle ==
                                                            positionTitleController
                                                                .text
                                                            ? positionTitle
                                                            .toString()
                                                            : positionTitleController
                                                            .text,
                                                        startDate ==
                                                            startDateContoller
                                                                .text
                                                            ? startDate
                                                            : startDateContoller
                                                            .text,
                                                        // Check if the end date is the same as the current end date or 'Currently Working'
                                                        // endDate == endDateController.text || endDateController.text == "Currently Working"
                                                        //     ? endDateController.text // If it's the same or "Currently Working", do not change the end date
                                                        //     : endDateController.text,
                                                        isSelectedEdit
                                                            ? "Currently Working"
                                                            : endDateController
                                                            .text,
                                                        emgMobile ==
                                                            emergencyMobileNumber
                                                                .text
                                                            ? emgMobile
                                                            : emergencyMobileNumber
                                                            .text,
                                                        country ==
                                                            countryController
                                                                .text
                                                            ? country.toString()
                                                            : countryController
                                                            .text,
                                                      );
                                                      if (response.statusCode ==
                                                          200 ||
                                                          response.statusCode ==
                                                              201) {
                                                        Navigator.pop(context);
                                                        showDialog(
                                                          context: context,
                                                          builder: (
                                                              BuildContext context) {
                                                            return AddSuccessPopup(
                                                              message: 'Employement Edited Successfully',
                                                            );
                                                          },
                                                        );
                                                      } else
                                                      if (response.statusCode ==
                                                          400 ||
                                                          response.statusCode ==
                                                              404) {
                                                        Navigator.pop(context);
                                                        showDialog(
                                                          context: context,
                                                          builder: (
                                                              BuildContext context) => const FourNotFourPopup(),
                                                        );
                                                      } else {
                                                        Navigator.pop(context);
                                                        showDialog(
                                                          context: context,
                                                          builder: (
                                                              BuildContext context) =>
                                                              FailedPopup(
                                                                  text: response
                                                                      .message),
                                                        );
                                                      }
                                                    },
                                                    checkBoxTile: StatefulBuilder(
                                                      builder: (
                                                          BuildContext context,
                                                          void Function(void Function()) setState) {
                                                        return Container(
                                                          width: 300,
                                                          child: CheckboxTile(
                                                            title: 'Currently work here',
                                                            initialValue: isSelectedEdit,
                                                            // Checkbox is checked based on isSelectedEdit
                                                            onChanged: (value) {
                                                              setState(() {
                                                                isSelectedEdit =
                                                                !isSelectedEdit;
                                                                if (isSelectedEdit) {
                                                                  endDateController
                                                                      .clear(); // Clear end date when "Currently Working" is selected
                                                                } else {
                                                                  endDateController
                                                                      .text =
                                                                  ''; // Or revert end date based on your logic
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    tite: 'Edit Employment',
                                                    onpressedClose: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                              );
                                            });
                                      },)
                                ),
                              ],
                            ),
                            title: 'Employment #${index + 1}',)

                      );
                    })
                );
              } else {
                return SizedBox();
              }
            }
        ),
      ],
    );
  }
}
