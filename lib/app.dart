import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather/weather.dart';

class App extends StatelessWidget {
  const App({required WeatherRepository weatherRepository, super.key})
      : _weatherRepo = weatherRepository;

  final WeatherRepository _weatherRepo;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherRepo,
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blueAccent,
            elevation: 0,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.white),
          ),
          primaryColor: Colors.greenAccent,
        ),
        home: const WeatherPage(),
      ),
    );
  }
}
