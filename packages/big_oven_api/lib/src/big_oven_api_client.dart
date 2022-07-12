import 'dart:convert';
import 'dart:developer';

import 'package:big_oven_api/big_oven_api.dart';
import 'package:dio/dio.dart';

/// Exception thrown when recipeSearch fails.
class RecipeRequestFailure implements Exception {}

/// Exception thrown when the provided recipe is not found.
class RecipeNotFoundFailure implements Exception {}

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

  static const _baseURL = 'api.bigoven.com';
  static const _recipeEndPoint = '/recipes';
  static const _headers = {'Content-Type': 'application/json'};

  
  /// Finds a [Recipe] `/recipes?query=(query)&page=(page)&rpp=(rpp)&api_key=(apiKey)`.
  Future<SearchResult> search({
    required String query,
    int page = 1,
  }) async {
    final queryParameters = <String, dynamic>{
      'title_kw': query, 'pg': '$page', 'rpp': '10', 'api_key': apiKey
    };

    log('Initialize request');
    final request = Uri.https(
      _baseURL, 
      _recipeEndPoint,
      queryParameters,
    );
    log('request: $_baseURL$_recipeEndPoint$queryParameters');

    final response = await _dio.getUri<String>(
      request,
      options: Options(headers: _headers),
    );

    if (response.statusCode != 200) {
      throw SearchResultError(
        message: response.data.toString(),
        query: query,
        page: page,
      );
    }

    final results 
      = json.decode(response.data.toString()) as Map<String, dynamic>;

    return SearchResult.fromJson(results);
  }
}
