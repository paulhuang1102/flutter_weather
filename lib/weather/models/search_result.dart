class SearchResult {
  const SearchResult({
    required this.locationName,
    required this.elements,
  });

  factory SearchResult.fromJson(Map<String, dynamic>json) {
    final elements = (json['weatherElement'] as List<dynamic>).map((el) => WeatherElement.fromJson(el)).toList();

    return SearchResult(
      locationName: json['locationName'],
      elements: elements);
  }

  
  final String locationName;
  final List<WeatherElement> elements;
}

class WeatherElement {
  const WeatherElement({
    required this.elementName,
    required this.time,
  });

  final String elementName;
  final List<TimeChunck> time;


  factory WeatherElement.fromJson(Map<String, dynamic>json ) {
    return WeatherElement(elementName: json['elementName'], time: []);
  }
}

class TimeChunck {

}