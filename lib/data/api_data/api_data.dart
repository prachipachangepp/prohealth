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

class ApiDataRegister{
  final bool success;
  final String message;
  final int statusCode;
  final Object? data;
  final int ?licenses;

  ApiDataRegister( {
    this.licenses,
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
});
}
