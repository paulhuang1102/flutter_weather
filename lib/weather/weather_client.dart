import 'package:dio/dio.dart';
import './weather.dart';

class WeatherClient {
  WeatherClient({
    required this.baseUrl,
    required this.authCode,
  }) {
    dio.options.baseUrl = baseUrl;
    dio.options.queryParameters = {'Authorization': authCode};
  }

  final Dio dio = Dio();
  final String baseUrl;
  final String authCode;

  Future<SearchResult> getWeatherIn36Hrs(String location) async {
    try {
      final response =
          await dio.get('/v1/rest/datastore/F-C0032-001', queryParameters: {
        ...dio.options.queryParameters,
        'locationName': location,
      });

      final records = response.data['records'];
      final locations = records['location'] as List<dynamic>;

      if (locations.isEmpty) {
        return SearchResult(locationName: location, elements: {});
      }

      return SearchResult.fromJson(locations[0]);
    } on DioException catch (e) {
      throw SearchResultError(message: e.message);
    }
  }
}