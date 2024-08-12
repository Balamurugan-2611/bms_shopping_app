import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  static final AppLocalization _singleton = AppLocalization._internal();
  Map<String, String> _localizedValues;

  AppLocalization._internal();

  static AppLocalization get instance => _singleton;

  Future<AppLocalization> load(Locale locale) async {
    try {
      String jsonStringValues = await rootBundle.loadString('assets/locale/localization_${locale.languageCode}.json');
      Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
      _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      // Handle error if the file can't be loaded or parsed
      print('Error loading localization file: $e');
      _localizedValues = {};
    }
    return this;
  }

  // Static member to have simple access to the delegate from MaterialApp
  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationsDelegate();

  String text(String key) {
    return _localizedValues[key] ?? "$key not found";
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    return AppLocalization.instance.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) => true;
}
