import 'package:equatable/equatable.dart';

enum ShowParam {
  wx('Wx'),
  pop('PoP'),
  mint('MinT'),
  maxt('MaxT'),
  ci('CI');

  const ShowParam(this.value);
  final String value;
}

class Weather extends Equatable{
  const Weather({
    required this.locationName,
    required this.data,
  });

  final String locationName;
  final List<WeatherData> data;
  
  @override
  List<Object?> get props => [locationName, data];
   
}

class WeatherData extends Equatable {
  const WeatherData({
    required this.startTime,
    required this.endTime,
    required this.parameters,
  });

  final DateTime startTime;
  final DateTime endTime;
  final Map<String, WeatherParameter> parameters;
  
  @override
  List<Object?> get props => [startTime, endTime, parameters];
}

class WeatherParameter extends Equatable {
  const WeatherParameter(this.name, { this.unit});

  final String name;
  final String? unit;
  
  @override
  List<Object?> get props => [name, unit];
}

extension StringWeatherX on String {
  String get toUnit {
    switch(this) {
      case '百分比':
        return '%';
      case 'C':
        return '°';
      default:
        return this;
    }
  }
}

extension CustomDateTimeX on DateTime {
  String get toCustomTime {
    final date = day > DateTime.now().day ? '明' : '今';
    final hour = this.hour > 12 ? this.hour - 12 : this.hour;
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.hour >= 12 ? 'PM' : 'AM';
    return '$date $hour:$minute $period';
  }
}