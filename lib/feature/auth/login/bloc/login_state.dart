part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isEmailInvalid;
  final bool isPasswordInvalid;
  final String email;
  final String password;

  bool get isFormValid => isEmailInvalid && isPasswordInvalid;

  LoginState({
     required this.isEmailInvalid,
     required this.isPasswordInvalid,
     required this.email,
     required this.password,
  });


  LoginState copyWith(
      {required bool isEmailInvalid,
      required bool isPasswordInvalid,
      required String email,
      required String password}) {
    return LoginState(
      isEmailInvalid: isEmailInvalid ?? this.isEmailInvalid,
      isPasswordInvalid: isPasswordInvalid ?? this.isPasswordInvalid,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [isEmailInvalid, isPasswordInvalid, email, password];
}


class LoginLoadingState extends LoginState {
  LoginLoadingState({required super.isEmailInvalid, required super.isPasswordInvalid, required super.email, required super.password});
}

class LoginFinishedState extends LoginState {
  final bool isSuccess;

  LoginFinishedState({required this.isSuccess, required super.isEmailInvalid, required super.isPasswordInvalid, required super.email, required super.password});

  @override
  List<Object> get props => [isSuccess];
}
