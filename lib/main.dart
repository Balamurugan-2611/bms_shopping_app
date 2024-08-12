import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bms_shopping_app/route/route_constants.dart';

import 'app.dart';
import 'bloc_observer.dart';
import 'db/db_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase and other services
  try {
    await Firebase.initializeApp();
    Bloc.observer = SimpleBlocObserver();
    await DBProvider.instance.init();

    // Uncomment and use authentication logic if needed
    // final authBloc = AuthBloc();
    // final initialRoute = await authBloc.isSignedIn()
    //     ? RouteConstant.homeRoute
    //     : RouteConstant.loginRoute;

    runApp(MyApp(
      initialRoute: RouteConstant.loginRoute, // Replace with `initialRoute` variable if needed
    ));
  } catch (e) {
    // Handle initialization errors
    print('Error during initialization: $e');
    runApp(MyApp(
      initialRoute: RouteConstant.errorRoute, // Optional: Provide an error route or fallback
    ));
  }
}
