import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bms_shopping_app/feature/auth/model/user_app.dart';  // Updated path
import 'package:bms_shopping_app/feature/profile/repository/profile_repository.dart';  // Updated path
import 'package:bms_shopping_app/feature/profile/repository/firebase_profile_repository.dart';  // Updated path

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc() : _profileRepository = FirebaseProfileRepository(), super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LogoutEvent) {
      yield* _mapLogoutEventToState();
    } else if (event is GetCurrentUser) {
      yield* _mapGetCurrentUserEventToState();
    }
  }

  Stream<ProfileState> _mapLogoutEventToState() async* {
    await _profileRepository.logout();
    yield LogoutFinished();
  }

  Stream<ProfileState> _mapGetCurrentUserEventToState() async* {
    try {
      final userData = await _profileRepository.getUserInfo();
      yield GetCurrentUserFinish(userData);
    } catch (e) {
      yield ProfileError('Failed to load user data');
    }
  }
}
