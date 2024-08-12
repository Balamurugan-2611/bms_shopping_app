import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(BlocBase bloc, Object event) {
    print("=======> onEvent: $event");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(BlocBase bloc, Transition<dynamic, dynamic> transition) {
    print("=======> onTransition: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print("=======> onError: $error");
    print("=======> StackTrace: $stackTrace");
    super.onError(bloc, error, stackTrace);
  }
}
