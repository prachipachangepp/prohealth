import 'dart:convert';

class SchedularData {
  final String zone;
  final int zoneId;
  final String correntLocation;
  final String expertise;
  final String fullname;
  final String status;
  final int totalPatients;
  final Compliance compliance;
  final Summary summary;
  final List<Calendar> calender;

  SchedularData({
    required this.zone,
    required this.zoneId,
    required this.correntLocation,
    required this.expertise,
    required this.fullname,
    required this.status,
    required this.totalPatients,
    required this.compliance,
    required this.summary,
    required this.calender,
  });
}

class Compliance {
  final String license;
  final int missedVisit;
  final dynamic qaisisForms;

  Compliance({
    required this.license,
    required this.missedVisit,
    this.qaisisForms,
  });
}

class Summary {
  final int earning;
  final String travel;
  final String totalTravel;
  final int visit;
  final int totalQAISIS;
  final int reAssigned;
  final int rescheduled;
  final int totalEarning;
  final int totalReAssigned;
  final int grandTotalQAISIS;

  Summary({
    required this.earning,
    required this.travel,
    required this.totalTravel,
    required this.visit,
    required this.totalQAISIS,
    required this.reAssigned,
    required this.rescheduled,
    required this.totalEarning,
    required this.totalReAssigned,
    required this.grandTotalQAISIS,
  });
}

class Calendar {
  final int schedulerCreateId;
  final int patientId;
  final int clinicianId;
  final String visitType;
  final String assignDate;
  final String startTime;
  final String endTime;
  final String details;
  final String patientFirstName;
  final String patientLastName;
  final String patientAddress;

  Calendar({required this.patientFirstName, required this.patientLastName, required this.patientAddress,
    required this.schedulerCreateId,
    required this.patientId,
    required this.clinicianId,
    required this.visitType,
    required this.assignDate,
    required this.startTime,
    required this.endTime,
    required this.details,
  });
}
class CalendarEvent {
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;

  CalendarEvent({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
  });
}

