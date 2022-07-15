import 'dart:convert';
import 'dart:developer';

import 'package:big_oven_api/big_oven_api.dart';
import 'package:dio/dio.dart';

/// {@template big_oven_api_client}
/// Dart API client which wraps the [BigOven Api](https://api2.bigoven.com/)
/// {@endtemplate}
class BigOvenApiClient {
  /// {@macro big_oven_api_client}
  BigOvenApiClient({
    Dio? dio, 
    this.apiKey = '?',
  })  : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseURL));
  
  final Dio _dio;

  /// The API_key
  final String apiKey;

  static const _baseURL = 'https://api.bigoven.com';
  static const _recipeEndPoint = '/recipes';
  static const _headers = {'Content-Type': 'application/json'};

  /// Finds a [SearchResult] `/recipes?title_kw=(query)&pg=(page)&rpp=(rpp)&api_key=(apiKey)`.
  Future<SearchResult> search({
    required String query,
    int page = 1,
    int rpp = 1,
  }) async {
    final queryParameters = <String, String>{
      'title_kw': query, 'pg': '$page', 'rpp': '$rpp', 'api_key': apiKey
    };
    
    final response = await _dio.get<String>(
      _recipeEndPoint,
      queryParameters: queryParameters,
      options: Options(headers: _headers),
    );
    log('Results gotten');
    final results 
      = json.decode(response.data.toString()) as Map<String, dynamic>;
    log('Decode gotten');
    if (response.statusCode != 200) {
      log('200 error');
      throw SearchResultError(
        page: page, 
        query: query, 
        message: response.statusMessage.toString(),
      );
    }
    return SearchResult.fromJson(results);
  }
}
