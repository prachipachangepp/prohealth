class ApiData {
  final bool success;
  final String message;
  final int statusCode;
  final Object? data;
  final String? imageUrl;
  final int? employeeId;
  final int? patientId;

  ApiData(
      {required this.statusCode,
      required this.success,
      required this.message,
      this.data, this.imageUrl, this.employeeId ,
        this.patientId,});
}

class ApiDataFilter {
  final bool success;
  final String message;
  final int statusCode;
  final Object? data;
  final String? imageUrl;
  final int? employeeId;

  ApiDataFilter(
      {required this.statusCode,
        required this.success,
        required this.message,
        this.data, this.imageUrl, this.employeeId });
}

class ApiDataRegister{
  final bool success;
  final String message;
  final int statusCode;
  final Object? data;
  final int? licenses;
  final int? banckingId;
  final int? educationId;

  ApiDataRegister({this.educationId,
    this.banckingId,
    this.licenses,
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
});
}
