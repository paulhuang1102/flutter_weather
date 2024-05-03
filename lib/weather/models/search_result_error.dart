class SearchResultError implements Exception {
  SearchResultError({this.message = 'unknown'});

  final String? message;
}