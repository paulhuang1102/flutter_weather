part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class SearchFetch extends WeatherEvent {
  const SearchFetch({required this.text});

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'SearchFetch { text: $text }';
}