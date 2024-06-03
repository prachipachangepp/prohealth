class ApiData {
  final bool success;
  final String message;
  final int statusCode;
  final Object? data;

  ApiData(
      {required this.statusCode,
      required this.success,
      required this.message,
      this.data});
}
