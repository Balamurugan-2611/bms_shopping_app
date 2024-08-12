part of 'profile_bloc.dart';

/// Base class for all Profile states
abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

/// Initial state when the profile feature is loaded
class ProfileInitial extends ProfileState {}

/// State indicating that the logout process has finished
class LogoutFinished extends ProfileState {}

/// State when user information has been successfully fetched
class GetCurrentUserFinish extends ProfileState {
  final UserData userData;

  GetCurrentUserFinish(this.userData);

  @override
  List<Object> get props => [userData];
}
