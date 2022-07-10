/// {@template cache_response}
/// A response from the cache
/// {@endtemplate}
class CacheResponse {
  /// {@macro cache_response}
  const CacheResponse({
    required this.responseData,
  });

  /// Converts a [Map<String, dynamic>] into a Response
  factory CacheResponse.fromJson(Map<String, dynamic> json) {
    return CacheResponse(
      responseData: json['responseData'],
    );
  }

  /// Converts the response into a [Map<String, dynamic>]
  Map<String, dynamic> toJson() {
    return {'responseData': responseData};
  }

  /// The data contained by the response
  final dynamic responseData;
}
