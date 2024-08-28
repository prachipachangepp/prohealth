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
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/scheduler/scheduler_create_manager.dart';
import 'package:prohealth/data/api_data/sm_data/scheduler_create_data/schedular_data.dart';

import 'assign_visit_pop_up.dart';

class CalenderConstant extends StatefulWidget {
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
  Future<void> fetchAndSetEvents(BuildContext context, int clinicianId) async {
    SchedularData? schedularData = await getSchedularByClinitian(context: context, clinicialId: clinicianId);

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
        print('EventController ${eventController}');
        // allEvents.add(
        //     CalendarEventData(
        //   title: calendarItem.visitType,
        //   description: calendarItem.details,
        //   date: startDate,
        //   startTime: startDate,
        //   endTime: endDate,
        // ));
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
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: ColorManager.blueprime,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.title, style: GoogleFonts.firaSans(
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.white,
                        )),
                        Text(event.description!,style: GoogleFonts.firaSans(
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.white,
                        )),
                        Text('Start: ${DateFormat('hh:mm a').format(event.startTime!)}', style: GoogleFonts.firaSans(
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s10,
                          color: ColorManager.white,
                        )),
                        Text('End: ${DateFormat('hh:mm a').format(event.endTime!)}', style: GoogleFonts.firaSans(
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s10,
                          color: ColorManager.white,
                        )),
                      ],
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
        return AssignVisitPopUp();
      },
    );
  }
}

