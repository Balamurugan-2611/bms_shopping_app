import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bms_shopping_app/feature/auth/helper/validators_transformer.dart';
import 'package:bms_shopping_app/feature/auth/login/repository/repository.dart';
import 'package:bms_shopping_app/feature/auth/model/user_app.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc({required LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapSubmittedLoginToState();
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.copyWith(
        email: email,
        isEmailInvalid: !ValidatorsTransformer.isValidEmail(email));
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.copyWith(
        password: password,
        isPasswordInvalid: !ValidatorsTransformer.isValidPassword(password));
  }

  Stream<LoginState> _mapSubmittedLoginToState() async* {
    if (!state.isEmailInvalid && !state.isPasswordInvalid) {
      try {
        final success = await _loginRepository.signIn(state.email, state.password);
        yield LoginFinishedState(isSuccess: success);
      } on Exception catch (e) {
        print(e);
        yield LoginFinishedState(isSuccess: false);
      }
    } else {
      yield LoginFinishedState(isSuccess: false);
    }
  }
}
