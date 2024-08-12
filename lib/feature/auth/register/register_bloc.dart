import 'package:rxdart/rxdart.dart';
import 'package:bms_shopping_app/feature/auth/helper/validators_transformer.dart';
import 'package:bms_shopping_app/feature/auth/login/repository/repository.dart';
import 'package:bms_shopping_app/feature/auth/model/user_app.dart';

class RegisterBloc with ValidatorsTransformer {
  final LoginRepository loginRepository;

  RegisterBloc() : loginRepository = FirebaseLoginRepository();

  final BehaviorSubject<String> _firstNameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _lastNameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _dobController = BehaviorSubject<String>();
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  // Getters for adding values to the streams
  Function(String) get onFirstNameChanged => _firstNameController.sink.add;
  Function(String) get onLastNameChanged => _lastNameController.sink.add;
  Function(String) get onDobChanged => _dobController.sink.add;
  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;

  // Streams for validation
  Stream<bool> get firstName$ => _firstNameController.stream.transform(validateRequireField);
  Stream<bool> get lastName$ => _lastNameController.stream.transform(validateRequireField);
  Stream<bool> get dob$ => _dobController.stream.transform(validateRequireField);
  Stream<String> get dobValue$ => _dobController.stream;
  Stream<bool> get email$ => _emailController.stream.transform(validateEmail);
  Stream<bool> get password$ => _passwordController.stream.transform(validatePassword);

  // Combined validation stream
  Stream<bool> get validateResult$ => Rx.combineLatest([
    firstName$,
    lastName$,
    email$,
    password$,
  ], (values) {
    final hasNoErrors = !values.contains(false);
    return hasNoErrors;
  });

  // Register function
  Future<bool> register() async {
    final userData = UserData()
      ..firstname = _firstNameController.value
      ..lastname = _lastNameController.value
      ..dob = _dobController.value
      ..email = _emailController.value
      ..password = _passwordController.value;

    return await loginRepository.register(userData);
  }

  // Function to change DOB
  void changeDob(String date) {
    _dobController.sink.add(date);
  }

  // Getter for DOB value
  String? get dobValue => _dobController.value;

  // Dispose function to close streams
  void dispose() {
    _firstNameController.close();
    _lastNameController.close();
    _dobController.close();
    _emailController.close();
    _passwordController.close();
  }
}
