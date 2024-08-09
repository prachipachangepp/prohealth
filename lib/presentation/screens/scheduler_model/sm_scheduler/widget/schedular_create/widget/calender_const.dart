import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:intl/intl.dart'; // Import the intl package


class CalenderConstant extends StatefulWidget {
  @override
  _CalenderConstantState createState() => _CalenderConstantState();
}

class _CalenderConstantState extends State<CalenderConstant> {
  String _selectedView = 'Week';

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedView = 'Day';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Blue background color
                        foregroundColor: Colors.white, // White text color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      child: Text('Day'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedView = 'Week';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Blue background color
                        foregroundColor: Colors.white, // White text color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      child: Text('Week'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedView = 'Month';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Blue background color
                        foregroundColor: Colors.white, // White text color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
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
    switch (_selectedView) {
      case 'Week':
        return WeekView(
          minDay: DateTime(1990),
          maxDay: DateTime(2050),
          initialDay: DateTime.now(),
          showLiveTimeLineInAllDays: true,
          heightPerMinute: 1,
          timeLineBuilder: (date) =>
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerRight,
                child: Text(
                  DateFormat('hh:mm a').format(date),
                  // 12-hour format with AM/PM
                  style: const TextStyle(fontSize: 12),
                ),
              ),
          timeLineWidth: 80,
          // Adjust this width as needed
          liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
            color: Colors.black,
            height: 2,
          ),
          eventArranger: const SideEventArranger(),

        );
      case 'Month':
        return MonthView(
          minMonth: DateTime(1990),
          maxMonth: DateTime(2050),
          initialMonth: DateTime.now(),
        );
      case 'Day':
      default:
        return DayView(
          minDay: DateTime(1990),
          maxDay: DateTime(2050),
          initialDay: DateTime.now(),
          showLiveTimeLineInAllDays: true,
          heightPerMinute: 1,
          timeLineBuilder: (date) =>
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerRight,
                child: Text(
                  DateFormat('hh:mm a').format(date),
                  // 12-hour format with AM/PM
                  style: const TextStyle(fontSize: 12),
                ),
              ),
          timeLineWidth: 80,
          // Adjust this width as needed
          liveTimeIndicatorSettings: const LiveTimeIndicatorSettings(
            color: Colors.black,
            height: 2,
          ),
          eventArranger: const SideEventArranger(),
        );
    }
  }
}