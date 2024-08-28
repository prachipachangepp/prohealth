import 'package:flutter/material.dart';

import 'intake_patients_plan_care.dart';

// class WeekProvider extends ChangeNotifier {
//   List<Week> _weeks = [
//     Week(weekNumber: 'Week 1', initialValue: '2'),
//     Week(weekNumber: 'Week 2', initialValue: '3'),
//   ];
//
//   List<Week> get weeks => _weeks;
//
//   void addWeek() {
//     _weeks.add(Week(
//       weekNumber: 'Week ${_weeks.length + 1}',
//       initialValue: '',
//     ));
//     notifyListeners();
//   }
// }

class WeekProvider extends ChangeNotifier {
  final Map<String, List<Week>> _containerWeeks = {};

  List<Week> getWeeks(String containerId) {
    return _containerWeeks[containerId] ?? [];
  }

  void addWeek(String containerId) {
    if (_containerWeeks.containsKey(containerId)) {
      _containerWeeks[containerId]!.add(Week(
        weekNumber: 'Week ${_containerWeeks[containerId]!.length + 1}',
        initialValue: '',
      ));
    } else {
      _containerWeeks[containerId] = [
        Week(
          weekNumber: 'Week 1',
          initialValue: '',
        ),
      ];
    }
    notifyListeners();
  }
}