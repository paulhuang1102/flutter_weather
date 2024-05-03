
import 'package:weather_report/weather/weather.dart';

class WeatherRepository {
  const WeatherRepository(this.client);

  final WeatherClient client;

  Future<SearchResult> search(String location) async {
    final result = await client.getWeatherIn36Hrs(location);

    return result;
  }
}