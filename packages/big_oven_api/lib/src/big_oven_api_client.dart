import 'dart:convert';

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
  static const _recipeEndPoint = '/recipe';
  static const _headers = {'content-Type': 'application/json'};

  
  /// Finds a [Recipe] `/recipe?query=(query)&page=(page)&rpp=(rpp)&api_key=(apiKey)`.
  Future<List<Recipe>> search({
    required String query,
    int page = 1,
  }) async {

    final queryParameters = <String, dynamic>{
      'title_kw': query, 'pg': page, 'rpp': 10, 'api_key': apiKey
    };

    final response = await _dio.get<dynamic>(
      _recipeEndPoint,
      queryParameters: queryParameters,
      options: Options(headers: _headers),
    );

    if (response.statusCode != 200) {
      throw RecipeRequestFailure();  
    }

    final jsonResponse = jsonDecode(response.data.toString()) as List;
      
    if (jsonResponse.isEmpty){
      throw RecipeNotFoundFailure();
    }

    return List<Recipe>.from(jsonResponse.map((e) => Recipe.fromJson));
  }
}
