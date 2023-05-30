class Endpoints {
  Endpoints._();

  static const String redirectUrl = 'com.example.recipe-manager://login-callback';
  // TODO: Keycloak SSL (set usesCleartextTraffic="false" in AndroidManifest.xml)
  static const String discoveryUrl = 'http://10.0.2.2:8180/realms/SpringBootKeycloak/.well-known/openid-configuration';
  static const String keycloakClientId = 'login-app';
  static const String baseUrl = 'http://10.0.2.2:8080'; //Localhost for Android emulator
  static const Duration connectionTimeout = Duration(milliseconds: 5000);
  static const Duration receiveTimeout = Duration(milliseconds: 3000);
}
