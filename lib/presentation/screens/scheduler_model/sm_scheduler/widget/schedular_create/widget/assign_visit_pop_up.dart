import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/font_manager.dart';
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

                        PopUpDropdown(labelText: '', initialValue: 'Select',),
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
                          await SchedulerCreate(
                            context,
                            1,
                            1,
                            selectedValue.toString(),
                            "2024-08-26T11:44:00Z",
                           // ctlrassignedate.text,
                            "2024-08-26T11:44:00Z",
                             // ctlrstarttime.text,
                            "2024-08-26T11:44:00Z",
                            // ctlrendtime.text,
                            ctlrdetails.text,
                          );

                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return SchedularSuccessPopup(title: 'Success',);
                          //   },
                          // );
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
