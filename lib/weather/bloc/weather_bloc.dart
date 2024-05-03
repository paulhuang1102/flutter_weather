import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:weather_report/weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._weatherRepo) : super(WeatherInitial()) {
    on<SearchFetch>(
      _onSearchFetch,
      transformer: debounce(_duration),
    );
  }

  final WeatherRepository _weatherRepo;

  Future<void> _onSearchFetch(
    SearchFetch event,
    Emitter<WeatherState> emit,
  ) async {
    final searchTerm = event.text;

    if (searchTerm.isEmpty) return emit(WeatherInitial());

    emit(WeatherStateLoading());

    try {
      final result = await _weatherRepo.search(searchTerm);

      if (result.elements.isEmpty) {
        return emit(const WeatherStateError(ErroType.inputInValid));
      }
      emit(WeatherStateSuccess());
    } on SearchResultError catch (e) {
      emit(WeatherStateError(ErroType.endpointError, msg: e.message));
    }
  }
}
