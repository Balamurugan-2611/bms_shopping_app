part of 'profile_bloc.dart';

/// Base class for all Profile events
abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event to log the user out
class LogoutEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

/// Event to fetch the current user's information
class GetCurrentUser extends ProfileEvent {
  @override
  List<Object> get props => [];
}
