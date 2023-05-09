class Endpoints {
  Endpoints._();

  static const String baseUrl = 'http://10.0.2.2:8080'; //Endpoint for Android emulator
  static const Duration connectionTimeout = Duration(milliseconds: 5000);
  static const Duration receiveTimeout = Duration(milliseconds: 3000);
}
