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
  WeatherBloc(this._weatherRepo) : super(WeatherStateInitial()) {
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

    if (searchTerm.isEmpty) return emit(WeatherStateInitial());

    emit(WeatherStateLoading());

    try {
      final result = await _weatherRepo.search(searchTerm);

      if (result.elements.isEmpty) {
        return emit(
          WeatherStateError(
            ErrorType.inputInValid,
            location: searchTerm,
          ),
        );
      }

      final dataLength =
          result.elements[result.elements.keys.first]?.length ?? 0;

      final List<WeatherData> data = [];

      for (int i = 0; i < dataLength; i++) {
        DateTime? startTime;
        DateTime? endTime;
        Map<String, WeatherParameter> parameterData = {};
        for (var v in result.elements.keys) {
          final chunks = result.elements[v];
          final param = chunks?[i];

          if (param == null) {
            continue;
          }
          startTime ??= param.startTime;
          endTime ??= param.endTime;

          parameterData[v] = 
              WeatherParameter(param.parameterName, unit: param.parameterUnit?.toUnit);
        }

        data.add(WeatherData(
          startTime: startTime!,
          endTime: endTime!,
          parameters: parameterData,
        ));
      }

      emit(WeatherStateSuccess(Weather(locationName: searchTerm, data: data)));
    } on SearchResultError catch (e) {
      emit(WeatherStateError(
        ErrorType.endpointError,
        msg: e.message,
        location: searchTerm,
      ));
    } catch (e) {
      emit(WeatherStateError(
        ErrorType.system,
        msg: e.toString(),
        location: searchTerm,
      ));
    }
  }
}
