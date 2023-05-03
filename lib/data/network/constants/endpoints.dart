class Endpoints {
  Endpoints._();

  static const String baseUrl = 'http://localhost:8080';
  static const Duration connectionTimeout = Duration(milliseconds: 5000);
  static const Duration receiveTimeout = Duration(milliseconds: 3000);
}
