class ApiData {
  final bool success;
  final String message;
  final int statusCode;
  final Object? data;
  final String? imageUrl;

  ApiData(
      {required this.statusCode,
      required this.success,
      required this.message,
      this.data, this.imageUrl, });
}

class ApiDataRegister{
  final bool success;
  final String message;
  final int statusCode;
  final Object? data;

  ApiDataRegister({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
});
}
