class EmployeeData {
  final String employeeType;
  final String abbreviation;

  EmployeeData({required this.employeeType, required this.abbreviation});

  Map<String, dynamic> toJson() {
    return {
      'employeeType': employeeType,
      'abbreviation': abbreviation,
    };
  }
}


class AdministrativeData {
  List<EmployeeData> employeeList = [];
  Future<void> loadEmployeeData() async {

    List<Map<String, dynamic>> jsonData = [
      {'employeeType': 'Human Resource Manager', 'abbreviation': 'HRM'},
      {'employeeType': 'Business Development', 'abbreviation': 'HRM'},
      {'employeeType': 'Accountant', 'abbreviation': 'HRM'},
      {'employeeType': 'Human Resource Manager', 'abbreviation': 'HRM'},
      {'employeeType': 'Business Development', 'abbreviation': 'HRM'},
      {'employeeType': 'Accountant', 'abbreviation': 'HRM'},
      {'employeeType': 'Intake', 'abbreviation': 'HRM'},
      {'employeeType': 'Patient Care Co ordinator', 'abbreviation': 'HRM'},
    ];


    employeeList = jsonData
        .map((data) => EmployeeData(
      employeeType: data['employeeType'],
      abbreviation: data['abbreviation'],
    ))
        .toList();
  }
}
