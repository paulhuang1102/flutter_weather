part of 'weather_bloc.dart';

enum ErroType {
  inputInValid,
  endpointError,
}

sealed class WeatherState extends Equatable {
  const WeatherState();
  
  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherStateEmpty extends WeatherState {}

final class WeatherStateLoading extends WeatherState {}

final class WeatherStateSuccess extends WeatherState {}

final class WeatherStateError extends WeatherState {
  const WeatherStateError(this.error, { this.msg = ''});

  final ErroType error;
  final String? msg;

  @override
  List<Object> get props => [error];
}