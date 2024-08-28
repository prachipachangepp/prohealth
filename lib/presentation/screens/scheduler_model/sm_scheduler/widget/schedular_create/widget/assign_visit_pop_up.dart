import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_visit_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_visit_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_insurance/widgets/intake_insurance_primary/intake_insurance_primary_screen.dart';
import '../../../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/sm_module_manager/physician_info/physician_info_manager.dart';
import '../../../../../../../app/services/api/managers/sm_module_manager/scheduler/scheduler_create_manager.dart';
import '../../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../../widgets/constant_widgets/schedular_success_popup.dart';
import '../../../../widgets/constant_widgets/textfield_constant.dart';

class AssignVisitPopUp extends StatefulWidget {
  const AssignVisitPopUp({super.key});

  @override
  State<AssignVisitPopUp> createState() => _AssignVisitPopUpState();
}

class _AssignVisitPopUpState extends State<AssignVisitPopUp> {
  TextEditingController ctlrdetails = TextEditingController();
  TextEditingController ctlrassignedate = TextEditingController();
  TextEditingController ctlrstarttime = TextEditingController();
  TextEditingController ctlrendtime = TextEditingController();
  //TextEditingController  = TextEditingController();

  String? selectedValue;
  String? docAddVisitType;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: ColorManager.blueprime,
        ),
        height: 47,
        width: 700,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Assign Visit',
                style: GoogleFonts.firaSans(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          height: 350,
          width: 600,
          color: ColorManager.white,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Patient',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        PopUpTextField(labelText: ''),
                      ],
                    ),
                  ),
                  SizedBox(width: 35),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assigned Clinician',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        PopUpTextField(labelText: ''),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assign Date',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        PopUpTextField(
                            labelText: '',
                            isDate: true,
                            initialValue: 'Select',
                            controller: ctlrassignedate),
                      ],
                    ),
                  ),
                  SizedBox(width: 35),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Visit Type',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        SizedBox(height: 5),

                        FutureBuilder<List<VisitListData>>(
                          future: getVisitList(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                  width: 354,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: ColorManager.faintGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                            }
                            if (snapshot.hasData && snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  AppString.dataNotFound,
                                  style: CustomTextStylesCommon.commonStyle(
                                    fontWeight: FontWeightManager.medium,
                                    fontSize: FontSize.s12,
                                    color: ColorManager.mediumgrey,
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasData) {
                              List<DropdownMenuItem<String>> dropDownZoneList = [];
                              for (var i in snapshot.data!) {
                                dropDownZoneList.add(
                                  DropdownMenuItem<String>(
                                    child: Text(i.visitType),
                                    value: i.visitType,
                                  ),
                                );
                              }
                              return CICCDropdown(
                                initialValue: dropDownZoneList.isNotEmpty
                                    ? dropDownZoneList[0].value
                                    : null,
                                onChange: (val) {
                                  for (var a in snapshot.data!) {
                                    if (a.visitType == val) {
                                      docAddVisitType = a.visitType;
                                    }
                                  }
                                },
                                items: dropDownZoneList,
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        // FutureBuilder<List<StateData>>(
                        //   future: getStateDropDown(context),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.waiting) {
                        //       return Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(horizontal: 7),
                        //         child: Container(
                        //             width: AppSize.s250,
                        //             height: AppSize.s40,
                        //             decoration: BoxDecoration(
                        //                 color: ColorManager.white),
                        //             child: Align(
                        //               alignment: Alignment.centerLeft,
                        //               child: Text(
                        //                 'Loading...',
                        //                 style: GoogleFonts.firaSans(
                        //                   fontSize: 12,
                        //                   color: ColorManager.mediumgrey,
                        //                   fontWeight: FontWeight.w400,
                        //                 ),
                        //               ),
                        //             )),
                        //       );
                        //     }
                        //     if (snapshot.hasData) {
                        //       List<String> dropDownList = [];
                        //       for (var i in snapshot.data!) {
                        //         dropDownList.add(i.name!);
                        //       }
                        //
                        //       return SizedBox(
                        //         height: 27,
                        //         child: DropdownButtonFormField<String>(
                        //           decoration: InputDecoration(
                        //             labelText: 'State',
                        //             labelStyle: GoogleFonts.firaSans(
                        //               fontSize: 10.0,
                        //               fontWeight: FontWeight.w400,
                        //               color: ColorManager.greylight,
                        //             ),
                        //             focusedBorder: OutlineInputBorder(
                        //               borderSide: BorderSide(
                        //                   color:
                        //                       ColorManager.containerBorderGrey),
                        //             ),
                        //             border: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(4.0),
                        //               borderSide:
                        //                   const BorderSide(color: Colors.grey),
                        //             ),
                        //             contentPadding: const EdgeInsets.symmetric(
                        //                 //   //  vertical: 5,
                        //                 horizontal: 12),
                        //           ),
                        //           // value: selectedCountry,
                        //           icon: Icon(
                        //             Icons.arrow_drop_down,
                        //             color: ColorManager.blueprime,
                        //           ),
                        //           iconSize: 24,
                        //           elevation: 16,
                        //           style: GoogleFonts.firaSans(
                        //             fontSize: 10.0,
                        //             fontWeight: FontWeight.w400,
                        //             color: const Color(0xff686464),
                        //           ),
                        //
                        //           onChanged: (newValue) {
                        //             for (var a in snapshot.data!) {
                        //               if (a.name == newValue) {
                        //                 selectedValue = a.name!;
                        //                 //country = a
                        //                 // int? docType = a.companyOfficeID;
                        //               }
                        //             }
                        //           },
                        //           items: dropDownList.map((String value) {
                        //             return DropdownMenuItem<String>(
                        //               value: value,
                        //               child: Text(
                        //                 value,
                        //                 style: GoogleFonts.firaSans(
                        //                   fontSize: 12,
                        //                   color: Color(0xff575757),
                        //                   fontWeight: FontWeight.w400,
                        //                 ),
                        //               ),
                        //             );
                        //           }).toList(),
                        //         ),
                        //       );
                        //
                        //       // );
                        //     } else {
                        //       return const Offstage();
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Time',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        PopUpTextField(
                          labelText: '',
                          isTime: true,
                          initialValue: 'Select',
                          controller: ctlrstarttime,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 35),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Time',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        PopUpTextField(
                          labelText: '',
                          isTime: true,
                          initialValue: 'Select',
                          controller: ctlrendtime,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Details',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                            height: 54,
                            child: PopUpTextField(
                                labelText: 'Enter Text',
                                controller: ctlrdetails))
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('Cancel',
                        style: GoogleFonts.firaSans(
                            fontWeight: FontWeightManager.bold,
                            fontSize: FontSize.s12,
                            color: ColorManager.mediumgrey)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 60),
                  SizedBox(
                    height: 31,
                    width: 105,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        child: Text(
                          'Add',
                          style: GoogleFonts.firaSans(
                            fontWeight: FontWeightManager.bold,
                            fontSize: FontSize.s12,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.blueprime,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          print('Assign Date  ${ctlrassignedate.text}');
                          print('Assign Start Time ${ctlrstarttime.text}');
                          print('Assign End Time ${ctlrendtime.text}');
                          var response = await SchedulerCreate(
                              context: context,
                              patientId: 1,
                              clinicianId: 134,
                              visitType: docAddVisitType.toString(),
                              assignDate: ctlrassignedate.text,
                              startTime: ctlrstarttime.text,
                              endTime: ctlrendtime.text,
                              details: ctlrdetails.text
                          );
                          if(response.statusCode == 200 || response.statusCode == 201){
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0), // Rounded corners
                                  ),
                                  child: Container(
                                    height: 270,
                                    width: 300,
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                                      color: Colors.white, // Background color
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          Icons.check_circle_outline,
                                          color: Color(0xFF50B5E5),
                                          size: 80.0,
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(
                                          "Successfully Add !",
                                          style: GoogleFonts.firaSans(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 30.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            CustomButton(
                                                height: 30,
                                                width: 130,
                                                text: 'Continue',
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }


                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
