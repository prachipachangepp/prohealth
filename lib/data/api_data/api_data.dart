class ApiData {
  final bool success;
  final String message;
  final int statusCode;
  final Object? data;
  final String? imageUrl;
  final int? employeeId;

  ApiData(
      {required this.statusCode,
      required this.success,
      required this.message,
      this.data, this.imageUrl, this.employeeId });
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

  ApiDataRegister({
    this.banckingId,
    this.licenses,
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
});
}
