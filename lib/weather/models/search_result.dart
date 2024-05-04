class SearchResult {
  const SearchResult({
    required this.locationName,
    required this.elements,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final Map<String, List<TimeChunck>> elements = {};

    for (var el in (json['weatherElement'] as List<dynamic>)) {
      final time = (el['time'] as List);
      elements[el['elementName']] =
          time.map((t) => TimeChunck.fromJson(t)).toList();
    }
    return SearchResult(
      locationName: json['locationName'],
      elements: elements,
    );
  }

  final String locationName;
  final Map<String, List<TimeChunck>> elements;
}

class TimeChunck {
  const TimeChunck({
    required this.startTime,
    required this.endTime,
    required this.parameterName,
    this.parameterUnit,
    this.parameterValue,
  });

  factory TimeChunck.fromJson(Map<String, dynamic> json) {
    final parameter = json['parameter'] as Map;

    return TimeChunck(
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      parameterName: parameter['parameterName'],
      parameterUnit: parameter['parameterUnit'],
      parameterValue: parameter['parameterValue'],
    );
  }

  final DateTime startTime;
  final DateTime endTime;
  final String parameterName;
  final String? parameterUnit;
  final String? parameterValue;
}
