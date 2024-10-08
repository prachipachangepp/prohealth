// import 'package:flutter/material.dart';
// import 'package:calendar_view/calendar_view.dart';
// import 'package:intl/intl.dart'; // Import the intl package
//
//
// class CalenderConstant extends StatefulWidget {
//   @override
//   _CalenderConstantState createState() => _CalenderConstantState();
// }
//
// class _CalenderConstantState extends State<CalenderConstant> {
//   String _selectedView = 'Week';
//
//   @override
//   Widget build(BuildContext context) {
//     return CalendarControllerProvider(
//       controller: EventController(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           backgroundColor: Colors.white,
//           body: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
//                 color: Colors.white,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           _selectedView = 'Day';
//                         });
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue, // Blue background color
//                         foregroundColor: Colors.white, // White text color
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 12),
//                       ),
//                       child: Text('Day'),
//                     ),
//                     const SizedBox(width: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           _selectedView = 'Week';
//                         });
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue, // Blue background color
//                         foregroundColor: Colors.white, // White text color
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 12),
//                       ),
//                       child: Text('Week'),
//                     ),
//                     const SizedBox(width: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           _selectedView = 'Month';
//                         });
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue, // Blue background color
//                         foregroundColor: Colors.white, // White text color
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 12),
//                       ),
//                       child: Text('Month'),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   color: Colors.redAccent,
//                   child: _buildCalendarView(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildCalendarView() {
//     switch (_selectedView) {
//       case 'Week':
//         return WeekView(
//           minDay: DateTime(1990),
//           maxDay: DateTime(2050),
//           initialDay: DateTime.now(),
//           showLiveTimeLineInAllDays: true,
//           heightPerMinute: 1,
//           timeLineBuilder: (date) =>
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   DateFormat('hh:mm a').format(date),
//                   // 12-hour format with AM/PM
//                   style: const TextStyle(fontSize: 12),
//                 ),
//               ),
//           timeLineWidth: 80,
//           // Adjust this width as needed
//           liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
//             color: Colors.black,
//             height: 2,
//           ),
//           eventArranger: const SideEventArranger(),
//
//         );
//       case 'Month':
//         return MonthView(
//           minMonth: DateTime(1990),
//           maxMonth: DateTime(2050),
//           initialMonth: DateTime.now(),
//         );
//       case 'Day':
//       default:
//         return DayView(
//           minDay: DateTime(1990),
//           maxDay: DateTime(2050),
//           initialDay: DateTime.now(),
//           showLiveTimeLineInAllDays: true,
//           heightPerMinute: 1,
//           timeLineBuilder: (date) =>
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   DateFormat('hh:mm a').format(date),
//                   // 12-hour format with AM/PM
//                   style: const TextStyle(fontSize: 12),
//                 ),
//               ),
//           timeLineWidth: 80,
//           // Adjust this width as needed
//           liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
//             color: Colors.black,
//             height: 2,
//           ),
//           eventArranger: const SideEventArranger(),
//         );
//     }
//   }
// }














///
// import 'package:flutter/material.dart';
// import 'package:calendar_view/calendar_view.dart';
// import 'package:intl/intl.dart';
//
// class CalenderConstant extends StatefulWidget {
//   @override
//   _CalenderConstantState createState() => _CalenderConstantState();
// }
//
// class _CalenderConstantState extends State<CalenderConstant> {
//   String _selectedView = 'Week';
//   EventController eventController = EventController();
//
//   @override
//   Widget build(BuildContext context) {
//     return CalendarControllerProvider(
//       controller: eventController,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           backgroundColor: Colors.white,
//           body: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
//                 color: Colors.white,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () => setState(() => _selectedView = 'Day'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       ),
//                       child: Text('Day'),
//                     ),
//                     const SizedBox(width: 10),
//                     ElevatedButton(
//                       onPressed: () => setState(() => _selectedView = 'Week'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       ),
//                       child: Text('Week'),
//                     ),
//                     const SizedBox(width: 10),
//                     ElevatedButton(
//                       onPressed: () => setState(() => _selectedView = 'Month'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       ),
//                       child: Text('Month'),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   color: Colors.redAccent,
//                   child: _buildCalendarView(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCalendarView() {
//     switch (_selectedView) {
//       case 'Week':
//         return WeekView(
//           controller: eventController,
//           minDay: DateTime(1990),
//           maxDay: DateTime(2050),
//           initialDay: DateTime.now(),
//           showLiveTimeLineInAllDays: true,
//           heightPerMinute: 1,
//           timeLineBuilder: _timeLineBuilder,
//           timeLineWidth: 80,
//           liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
//             color: Colors.black,
//             height: 2,
//           ),
//           eventArranger: const SideEventArranger(),
//           onDateLongPress: _onDateLongPress,
//         );
//       case 'Month':
//         return MonthView(
//           controller: eventController,
//           minMonth: DateTime(1990),
//           maxMonth: DateTime(2050),
//           initialMonth: DateTime.now(),
//           onCellTap: (events, date) => _onDateLongPress(date),
//         );
//       case 'Day':
//       default:
//         return DayView(
//           controller: eventController,
//           minDay: DateTime(1990),
//           maxDay: DateTime(2050),
//           initialDay: DateTime.now(),
//           showLiveTimeLineInAllDays: true,
//           heightPerMinute: 1,
//           timeLineBuilder: _timeLineBuilder,
//           timeLineWidth: 80,
//           liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
//             color: Colors.black,
//             height: 2,
//           ),
//           eventArranger: const SideEventArranger(),
//           onDateLongPress: _onDateLongPress,
//         );
//     }
//   }
//
//   Widget _timeLineBuilder(DateTime date) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       alignment: Alignment.centerRight,
//       child: Text(
//         DateFormat('hh:mm a').format(date),
//         style: const TextStyle(fontSize: 12),
//       ),
//     );
//   }
//
//   void _onDateLongPress(DateTime date) {
//     String eventTitle = '';
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Create Event'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('Date: ${DateFormat('yyyy-MM-dd HH:mm').format(date)}'),
//             TextField(
//               decoration: InputDecoration(labelText: 'Event Title'),
//               onChanged: (value) {
//                 eventTitle = value;
//               },
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             child: Text('Cancel'),
//             onPressed: () => Navigator.pop(context),
//           ),
//           TextButton(
//             child: Text('Create'),
//             onPressed: () {
//               _createEvent(date, eventTitle);
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _createEvent(DateTime date, String title) {
//     if (title.isNotEmpty) {
//       final event = CalendarEventData(
//         date: date,
//         title: title,
//         description: 'Event description',
//         startTime: date,
//         endTime: date.add(Duration(hours: 1)),
//         color: Colors.blue,
//       );
//       setState(() {
//         eventController.add(event);
//       });
//       print('Event created: ${event.title} at ${event.date}');
//     }
//   }
// }




import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_visit_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/scheduler/scheduler_create_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_visit_data.dart';
import 'package:prohealth/data/api_data/sm_data/scheduler_create_data/create_data.dart';
import 'package:prohealth/data/api_data/sm_data/scheduler_create_data/schedular_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_scheduler/widget/schedular_create/widget/edit_calender_schedule_popup.dart';

import 'assign_visit_pop_up.dart';

class CalenderConstant extends StatefulWidget {
  final SchedularData schedularData;
  CalenderConstant({required this.schedularData});
  @override
  _CalenderConstantState createState() => _CalenderConstantState();
}

class _CalenderConstantState extends State<CalenderConstant> {
  String _selectedView = 'Week';
  final EventController eventController = EventController();

  @override
  void initState() {
    super.initState();
    fetchAndSetEvents(context, 134); // Assuming clinicianId is 134 for demonstration purposes
  }
  List<CalendarEventData> allEvents = [];
  Map<CalendarEventData, int> eventSchedulerMap = {}; // Map to store the event and schedulerId
  Future<void> fetchAndSetEvents(BuildContext context, int clinicianId) async {
    SchedularData schedularData = await getSchedularByClinitian(context: context, clinicialId: 134);
    if (schedularData != null && schedularData.calender != null) {
      var assignedDate;
      DateTime staticStartTime1 = DateTime(2024, 8, 29, 01, 00); // August 20, 2024, 10:00 AM
      //DateTime staticEndTime = DateTime(2024, 8, 29, 02, 30);

      for (var calendarItem in schedularData.calender) {
        var date = DateTime.parse(calendarItem.assignDate);
        assignedDate =  DateFormat('yyyy, MM, dd').format(date);
        DateTime startTime = DateTime.parse(calendarItem.startTime);
        DateTime endTime = DateTime.parse(calendarItem.endTime);
        DateTime assignStartTime = DateTime(date.year, date.month, date.day, startTime.hour,startTime.minute);
        DateTime assignendTime = DateTime(date.year, date.month, date.day, endTime.hour,endTime.minute);
        var formatedStartTime = DateFormat('yyyy, MM, dd, HH, mm').format(assignStartTime);
        var formatedEndTime = DateFormat('yyyy, MM, dd, HH, mm').format(assignendTime);
        List<String> endTimeParts = formatedEndTime.split(', ');
        List<String> startTimeParts = formatedStartTime.split(', ');
        int startTimeYear = int.parse(startTimeParts[0]);
        int startTimeMonth = int.parse(startTimeParts[1]);
        int startTimeDay = int.parse(startTimeParts[2]);
        int startTimeHour = int.parse(startTimeParts[3]);
        int startTimeMinute = int.parse(startTimeParts[4]);

        int endTimeYear = int.parse(endTimeParts[0]);
        int endTimeMonth = int.parse(endTimeParts[1]);
        int endTimeDay = int.parse(endTimeParts[2]);
        int endTimeHour = int.parse(endTimeParts[3]);
        int endTimeMinute = int.parse(endTimeParts[4]);
        DateTime staticStartTime = DateTime(startTimeYear, startTimeMonth, startTimeDay, startTimeHour, startTimeMinute);
        DateTime staticendTime = DateTime(endTimeYear, endTimeMonth, endTimeDay, endTimeHour, endTimeMinute);
        print("Formated Date ${staticendTime}");
        print('static date ${staticStartTime1}');

        // Create CalendarEventData for each event
        CalendarEventData event = CalendarEventData(
          title: calendarItem.visitType,
          description: calendarItem.details,
          date: date,
          startTime: staticStartTime,
          endTime: staticendTime,
        );

        eventController.add(event);
        eventSchedulerMap[event] = calendarItem.schedulerCreateId;
        print('EventController ${eventController}');
        print('Event ${event.title} has schedulerId ${calendarItem.schedulerCreateId}');

        print("Event ${eventController.allEvents}");
        try{
          //CalendarControllerProvider.of(context).controller.add(eventData);
          print(allEvents.length);
          //allEvents.add(eventData);
        }catch(e){
          print(e);
        }
      }
      print("Eventes ${allEvents}");

     
    } else {
      print("No events found or data is null.");
    }
  }
  TextEditingController ctlrdetails = TextEditingController();
  TextEditingController ctlrassignedate = TextEditingController();
  TextEditingController ctlrstarttime = TextEditingController();
  TextEditingController ctlrendtime = TextEditingController();

  /// Edit time
  TextEditingController editCtlrdetails = TextEditingController();
  TextEditingController editCtlrassignedate = TextEditingController();
  TextEditingController editCctlrstarttime = TextEditingController();
  TextEditingController editCctlrendtime = TextEditingController();
  TextEditingController editCctlrendClinitianName = TextEditingController();
  TextEditingController editCctlrendPatientName = TextEditingController();
  //TextEditingController  = TextEditingController();

  String? selectedValue;
  String? docAddVisitType;

  /// Edit schedule
  String? editSelectedValue;
  String? editDocAddVisitType;

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: eventController,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => _selectedView = 'Day'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedView == 'Day' ? ColorManager.blueprime : ColorManager.white,
                        foregroundColor: _selectedView == 'Day' ? ColorManager.white : ColorManager.mediumgrey,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: Text('Day'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => setState(() => _selectedView = 'Week'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedView == 'Week' ? ColorManager.blueprime : ColorManager.white,
                        foregroundColor: _selectedView == 'Week' ? ColorManager.white : ColorManager.mediumgrey,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: Text('Week'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => setState(() => _selectedView = 'Month'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedView == 'Month' ? ColorManager.blueprime : ColorManager.white,
                        foregroundColor: _selectedView == 'Month' ? ColorManager.white : ColorManager.mediumgrey,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: Text('Month'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.redAccent,
                  child: _buildCalendarView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarView() {
    try {
      switch (_selectedView) {
        case 'Week':
          return
            WeekView(
            controller: eventController,
            eventTileBuilder: (date, events, boundary, start, end) {
              return ListView(
                children: events.map((event) {
                  return InkWell(
                    onTap: (){
                      int? schedulerId = eventSchedulerMap[event];
                      if(schedulerId != null){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return FutureBuilder<CreatePrefillDataScheduler>(future: getPreFillCalenderData(context: context,schedulerCreateId: schedulerId),
                              builder: (BuildContext context,snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
                                }
                                var patientId = snapshot.data!.patientId;
                                var details = snapshot.data!.details;
                                editCtlrdetails = TextEditingController(text: snapshot.data!.details);

                                //var patientName = "${snapshot.data!.patientFirstName} ${snapshot.data!.patientLastName}";

                                var assignedate = snapshot.data!.assignDate;
                                editCtlrassignedate = TextEditingController(text: snapshot.data!.assignDate);

                                var startTime = snapshot.data!.startTime;
                                editCctlrstarttime = TextEditingController(text: snapshot.data!.startTime);

                                var endTime = snapshot.data!.endTime;
                                editCctlrendtime = TextEditingController(text: snapshot.data!.endTime);
                                return EditCalenderSchedulePopup(onPressed: () async{
                                  var response = await updateScheduleCalender(
                                    context: context, schedulerCreateId: schedulerId,
                                    patientId: 1, clinicianId: 134,
                                    visitType: docAddVisitType!,
                                    assignDate: assignedate == editCtlrassignedate.text ? assignedate.toString() : editCtlrassignedate.text,
                                    startTime: startTime == editCctlrstarttime.text ? startTime.toString() :editCctlrstarttime.text ,
                                    endTime: endTime == editCctlrendtime.text ? endTime.toString() : editCctlrendtime.text,
                                    details: details == editCtlrdetails.text ? details.toString() : editCtlrdetails.text,);

                                  fetchAndSetEvents(context, 134);
                                  if(response.statusCode == 200 || response.statusCode == 201){
                                    ctlrassignedate.clear();
                                    ctlrstarttime.clear();
                                    ctlrendtime.clear();
                                    ctlrdetails.clear();
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
                                                  "Successfully Edit !",
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
                                  ctlrdetails: editCtlrdetails, ctlrassignedate: editCtlrassignedate,
                                  ctlrstarttime: editCctlrstarttime, ctlrendtime: editCctlrendtime,
                                  child: FutureBuilder<List<VisitListData>>(
                                    future: getVisitList(context),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Container(
                                          width: 354,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: ColorManager.white,
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
                                              fontSize: FontSize.s14,
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
                                );
                              },

                            );
                          },
                        );
                      }else{
                        print("ScheduleId error");
                      }

                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          top: BorderSide(color: ColorManager.green, width: 2.0),
                          right: BorderSide(color: ColorManager.green, width: 2.0),
                          bottom: BorderSide(color: ColorManager.green, width: 2.0),
                          left: BorderSide(color: ColorManager.green, width: 2.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.title, style: GoogleFonts.firaSans(
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.mediumgrey,
                          )),
                          Text(event.description!,style: GoogleFonts.firaSans(
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.mediumgrey,
                          )),
                          Text('Start: ${DateFormat('hh:mm a').format(event.startTime!)}', style: GoogleFonts.firaSans(
                            fontWeight: FontWeightManager.bold,
                            fontSize: FontSize.s10,
                            color: ColorManager.mediumgrey,
                          )),
                          Text('End: ${DateFormat('hh:mm a').format(event.endTime!)}', style: GoogleFonts.firaSans(
                            fontWeight: FontWeightManager.bold,
                            fontSize: FontSize.s10,
                            color: ColorManager.mediumgrey,
                          )),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            fullDayEventBuilder: (events, date) {
              return ListView(
                children: events.map((event) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text(event.description!, style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
            minDay: DateTime(1990),
            maxDay: DateTime(2050),
            initialDay: DateTime.now(),
            showLiveTimeLineInAllDays: true,
            heightPerMinute: 1,
            timeLineBuilder: _timeLineBuilder,
            timeLineWidth: 80,
            liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
              color: Colors.black,
              height: 2,
            ),
            eventArranger: const SideEventArranger(),
            onDateTap: _onDateLongPress,
          );
        case 'Month':
          return MonthView(
            controller: eventController,
            minMonth: DateTime(1990),
            maxMonth: DateTime(2050),
            onCellTap: (events, date) => _onDateLongPress(date),
          );
        case 'Day':
        default:
          return DayView(
            controller: eventController,
            minDay: DateTime(1990),
            maxDay: DateTime(2050),
            initialDay: DateTime.now(),
            showLiveTimeLineInAllDays: true,
            heightPerMinute: 1,
            timeLineBuilder: _timeLineBuilder,
            timeLineWidth: 80,
            liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
              color: Colors.black,
              height: 2,
            ),
            eventArranger: const SideEventArranger(),
            onDateLongPress: _onDateLongPress,
          );
      }
    } catch (e) {
      print('Error occurred: $e');
      return Center(
        child: Text(
          'Something went wrong',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  }

  Widget _timeLineBuilder(DateTime date) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.centerRight,
      child: Text(
        DateFormat('hh:mm a').format(date),
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  void _onDateLongPress(DateTime date) {
    showDialog(
      context: context,
      builder: (context) {
        return AssignVisitPopUp(
          clinicialName: editCctlrendClinitianName,
          patientNameController: TextEditingController(text:"${widget.schedularData.calender[0].patientFirstName} ${widget.schedularData.calender[0].patientLastName}"),
          assignDate: ctlrassignedate,
         startTime: ctlrstarttime,
        endTime: ctlrendtime,
        details: ctlrdetails,
        dropdown: FutureBuilder<List<VisitListData>>(
          future: getVisitList(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: 354,
                height: 30,
                decoration: BoxDecoration(
                  color: ColorManager.white,
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
                    fontSize: FontSize.s14,
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
              docAddVisitType = snapshot.data![0].visitType;
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
            fetchAndSetEvents(context, 134);
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
        }, );
      },
    );
  }
}


