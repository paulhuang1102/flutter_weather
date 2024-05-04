import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_report/app.dart';
import 'package:weather_report/weather/weather.dart';

import 'weather_bloc_observer.dart';

void main() {
  final weatherRepo = WeatherRepository(
    WeatherClient(
        baseUrl: 'https://opendata.cwa.gov.tw/api',
        // TODO: For Demo, it should be ignored
        authCode: 'CWA-F1F0DA9F-7EC4-4024-8B81-16DE8BEC0874'),
  );
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const WeatherBlocObserver();
  
  runApp(
    App(
      weatherRepository: weatherRepo,
    ),
  );
}
