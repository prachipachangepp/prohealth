
import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/dashboard/hr_dashboard.dart';
import 'package:prohealth/data/api_data/dashboard/hr_dashboard/hr_dashboard_part_one_data.dart';
import '../../../../token/token_manager.dart';

///GET /hr-dropdowns/total/employees/newJoinee/{companyId}
Future<NewJoineeDash?> HrDashNewJoineeGet(BuildContext context) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(path: HrDashboardRepository.getNewJoinee(companyId: companyId));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("New Joinee API Response: ${response.data}");
      final data = response.data;
      if (data != null) {
        return NewJoineeDash(
          totalEmployees: data['totalEmployees'] ?? 0,
          newJoineesCount: data['newJoineesCount'] ?? 0,
        );
      }
    } else {
      print('API Error: Status Code ${response.statusCode}');
    }
  } catch (e) {
    print("Error fetching new joinee data: $e");
  }
  return null;
}
