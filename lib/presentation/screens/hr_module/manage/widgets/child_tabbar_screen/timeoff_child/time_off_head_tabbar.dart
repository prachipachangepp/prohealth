import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/timeoff_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/timeoff_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/timeoff_child/edit_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/timeoff_child/inkewell_text_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';

class TimeOffHeadTabbar extends StatefulWidget {
  const TimeOffHeadTabbar({super.key});

  @override
  State<TimeOffHeadTabbar> createState() => _TimeOffHeadTabbarState();
}

class _TimeOffHeadTabbarState extends State<TimeOffHeadTabbar> {
  TextEditingController ptoController = TextEditingController();
  TextEditingController _controllerStartDate = TextEditingController();
  TextEditingController _controllerEndDate = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController sickTimeController = TextEditingController();
  final StreamController<List<TimeOfffData>> timeOffStremController =
      StreamController<List<TimeOfffData>>();

  late int currentPage;

  late int itemsPerPage;

  late List<String> items;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(60, (index) => 'Item ${index + 1}');
    // companyAllApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: timeOffStremController.stream,
        builder: (context, snapshot) {
          getEmployeeTimeOff(context,).then((data) {
            timeOffStremController.add(data);
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
                child: Text(
              AppString.dataNotFound,
              style: CustomTextStylesCommon.commonStyle(
                  fontWeight: FontWeightManager.medium,
                  fontSize: FontSize.s12,
                  color: ColorManager.mediumgrey),
            ));
          }
          if (snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height / 1,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('MM/dd/yyyy').format(pickedDate);
                            _controllerStartDate.text = formattedDate;
                          }
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: Color(0xff686464),
                          size: 18,
                        ),
                        label: Text(
                          _controllerStartDate.text == "" ?'Start Date':_controllerStartDate.text,
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686464),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Color(0xffB6B6B6)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('MM/dd/yyyy').format(pickedDate);
                            _controllerEndDate.text = formattedDate;
                          }
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: Color(0xff686464),
                          size: 18,
                        ),
                        label: Text(
                        _controllerEndDate.text == "" ?'End Date':_controllerEndDate.text,
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686464),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Color(0xffB6B6B6)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/40,),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Text(''),
                          Expanded(
                            child: Center(
                              child: Text(
                                AppString.znNo,
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                          Expanded(
                            child: Center(
                              child: Text('Action',
                                  //textAlign: TextAlign.start,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text('Time off Request',
                                  //textAlign: TextAlign.start,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text('Reason',
                                  //textAlign: TextAlign.start,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text('Hours',
                                  //textAlign: TextAlign.start,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text('Start Time',
                                  //textAlign: TextAlign.start,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text('End Time',
                                  //textAlign: TextAlign.start,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text('Sick Time',
                                  //textAlign: TextAlign.start,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  )),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Text('  ',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var timeOff = snapshot.data![index];
                          int serialNumber =
                              index + 1 + (currentPage - 1) * itemsPerPage;
                          String formattedSerialNumber =
                              serialNumber.toString().padLeft(2, '0');
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    height: 40,
                                    child: Stack(children: [
                                      Container(
                                        width: 10,
                                        color: ColorManager.blueprime,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  formattedSerialNumber,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Text(''),
                                            Expanded(
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // CircleAvatar(
                                                    //   radius: 10,
                                                    //   child:  Center(child: Icon(Icons.person,color:Colors.grey,)),
                                                    // ),
                                                    Icon(Icons.person,color:Colors.grey,size: 17,),
                                                    Text(
                                                      timeOff.employeeName,
                                                      //textAlign: TextAlign.center,
                                                      style:
                                                          GoogleFonts.firaSans(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            Color(0xff686464),
                                                        decoration:
                                                            TextDecoration.none,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  timeOff.timeOffRequest,
                                                  //textAlign: TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  timeOff.reson,
                                                  //textAlign: TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  timeOff.hours,
                                                  //textAlign: TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  timeOff.startTime,
                                                  //textAlign: TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  timeOff.endTime,
                                                  //textAlign: TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  timeOff.sickTime,
                                                  //textAlign: TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    snapshot.data![index].approved == true ?
                                                    Text('Approved',
                                                        textAlign: TextAlign.center,
                                                        style: CustomTextStylesCommon.commonStyle(
                                                            fontSize: FontSize.s12,
                                                            fontWeight: FontWeightManager.bold,
                                                            color: ColorManager.blueprime)):
                                                    TextInkwellButton(
                                                      text: 'Approve',
                                                      onTap: () async{
                                                        await approveTimeOffPatch(context, snapshot.data![index].employeeTimeOffId);
                                                      },
                                                    ),
                                                        // :SizedBox(),
                                                    TextInkwellButton(
                                                      text: 'Reject',
                                                      onTap: () {},
                                                    ),
                                                    TextInkwellButton(
                                                      text: 'Edit',
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return FutureBuilder<TimeOfPrefillData>(
                                                                future: getEmployeePrefillTimeOff(context,snapshot.data![index].employeeTimeOffId),
                                                                builder: (context,snapshotPrefill) {
                                                                  if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                                                    return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
                                                                  }
                                                                  var startTime = snapshotPrefill.data!.startTime;
                                                                  startTimeController = TextEditingController(text: snapshotPrefill.data!.startTime);

                                                                  var endTime = snapshotPrefill.data!.endTime;
                                                                  endTimeController = TextEditingController(text: snapshotPrefill.data!.endTime);

                                                                  var sickTime = snapshotPrefill.data!.sickTime;
                                                                  sickTimeController = TextEditingController(text: snapshotPrefill.data!.sickTime);
                                                                  return EditTimeOffPopup(
                                                                    ptoController:
                                                                        ptoController,
                                                                    durationController:
                                                                        durationController,
                                                                    startTimeController:
                                                                        startTimeController,
                                                                    endTimeController:
                                                                        endTimeController,
                                                                    sickTimeController:
                                                                        sickTimeController,
                                                                    labelName:
                                                                        'Edit Time Off',
                                                                    onPressed:
                                                                        () async{
                                                                         await updateEmployeeTimeOffPatch(context, snapshotPrefill.data!.employeeTimeOffId, snapshotPrefill.data!.employeeId,
                                                                             snapshotPrefill.data!.timeOffRequest, snapshotPrefill.data!.reson, startTime == startTimeController.text ? startTime.toString() :startTimeController.text,
                                                                             endTime == endTimeController.text ? endTime.toString() : endTimeController.text, sickTime == sickTimeController.text ? sickTime.toString() : sickTimeController.text,
                                                                             snapshotPrefill.data!.hours);
                                                                        },
                                                                  );
                                                                }
                                                              );
                                                            });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            //  Text(''),
                                          ],
                                        ),
                                      ),
                                    ])),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        });
  }
}
