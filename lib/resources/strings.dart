import 'package:shopping_app/localization/app_localization.dart';

class Strings {
  // Using getter methods to ensure localization is retrieved at runtime
  String get passwordLabel => AppLocalization.instance.text('passwordLabel') ?? 'Password';
  String get errorMsgPwd => AppLocalization.instance.text('errorMsgPwd') ?? 'Invalid password';
  String get errorMsgCommon => AppLocalization.instance.text('errorMsgCommon') ?? 'An error occurred';
  String get errorMsgEmail => AppLocalization.instance.text('errorMsgEmail') ?? 'Invalid email address';
  String get emailLabel => AppLocalization.instance.text('emailLabel') ?? 'Email';
  String get forgotPassword => AppLocalization.instance.text('forgotPassword') ?? 'Forgot Password';
  String get registerTitle => AppLocalization.instance.text('registerTitle') ?? 'Register';
  String get firstName => AppLocalization.instance.text('firstName') ?? 'First Name';
  String get lastName => AppLocalization.instance.text('lastName') ?? 'Last Name';
  String get username => AppLocalization.instance.text('username') ?? 'Username';
  String get dob => AppLocalization.instance.text('dob') ?? 'Date of Birth';
  String get dummyShipping1 => AppLocalization.instance.text('dummyShipping1') ?? 'Shipping Info';

  // General
  String get loginTitle => AppLocalization.instance.text('loginTitle') ?? 'Login';
  String get facebook => AppLocalization.instance.text('facebook') ?? 'Facebook';
  String get google => AppLocalization.instance.text('google') ?? 'Google';
  String get appName => AppLocalization.instance.text('appName') ?? 'App Name';
}
