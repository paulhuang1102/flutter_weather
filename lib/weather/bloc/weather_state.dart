part of 'weather_bloc.dart';

enum ErrorType {
  inputInValid,
  endpointError,
  system,
}

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherStateInitial extends WeatherState {}

final class WeatherStateLoading extends WeatherState {}

final class WeatherStateSuccess extends WeatherState {
  const WeatherStateSuccess(this.weather);

  final Weather weather;
}

final class WeatherStateError extends WeatherState {
  const WeatherStateError(this.error, {this.msg = '', required this.location});

  final ErrorType error;
  final String? msg;
  final String location;

  @override
  List<Object> get props => [error];
}
