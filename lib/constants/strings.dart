class Strings {
  Strings._();

  static const String appName = 'Recipe Manager Project';
  static const String home = 'Home Page';
  static const String login = 'Login Page';

  //Images
  static const String loginPageLogoPath = 'images/flutter_logo.png';

  //Login
  static const String usernameFieldText = 'Username';
  static const String passwordFieldText = 'Password';
  static const String forgotPasswordButtonText = 'Forgot Password';
  static const String loginButtonText = 'Login';
  static const String logoutButtonText = 'Logout';
  static const String createAccountButtonText = 'New User? Create Account';
  static const String expiredSessionDialogTitle = 'Session Expired';
  static const String expiredSessionDialogContent = 'Please log in again.';
  static const String okButton = 'Ok';

  //Home
  static String appBarTitle(String userName) => 'Hello $userName';
  static const String emptyRecipeIndex =
      'No recipes were found.\n\nTap \'Scan\' to add some now.';

  //Dio client
  static const String getErrorLogMessage = 'Unable to get recipes';
  static const String getErrorUserMessage =
      'Unable to load recipes.\nTry logging out and logging back in.';
  static const String putErrorLogMessage = 'Error creating RecipeIndex:\n';
  static const String putErrorUserMessage =
      'Unable to save recipes.\nTry logging out and logging back in.';
}
