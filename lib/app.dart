import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bms_shopping_app/feature/auth/login/bloc/login_bloc.dart';
import 'package:bms_shopping_app/localization/app_localization.dart';
import 'package:bms_shopping_app/route/router.dart';

import 'feature/cart/bloc/cart_bloc.dart';
import 'feature/discover/bloc/discover_bloc.dart';
import 'feature/home/home.dart';
import 'feature/product_details/bloc/product_details_bloc.dart';
import 'feature/profile/bloc/profile_bloc.dart';

class MyApp extends StatefulWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final DiscoverBloc discoverBloc;
  late final CartBloc cartBloc;
  late final ProductDetailsBloc productDetailsBloc;
  late final ProfileBloc profileBloc;
  late final LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    discoverBloc = DiscoverBloc();
    cartBloc = CartBloc();
    productDetailsBloc = ProductDetailsBloc();
    profileBloc = ProfileBloc();
    loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => discoverBloc),
        BlocProvider(create: (context) => cartBloc..add(CartLoadingEvent())),
        BlocProvider(create: (context) => profileBloc),
        BlocProvider(create: (context) => productDetailsBloc),
        BlocProvider(create: (context) => loginBloc),
      ],
      child: MaterialApp(
        initialRoute: widget.initialRoute,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
        locale: const Locale('en', ''),
        supportedLocales: const [
          Locale('en', ''), // English
          Locale('vi', ''), // Vietnamese
        ],
        localizationsDelegates: const [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    discoverBloc.close();
    cartBloc.close();
    productDetailsBloc.close();
    profileBloc.close();
    loginBloc.close();
    super.dispose();
  }
}
