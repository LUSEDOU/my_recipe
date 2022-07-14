import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:big_oven_api/big_oven_api.dart';
import 'package:http/http.dart' as http;

/// {@template big_oven_api_client}
/// Dart API client which wraps the [BigOven Api](https://api2.bigoven.com/)
/// {@endtemplate}
class BigOvenApiClientHTTP {
  /// {@macro big_oven_api_client}
  BigOvenApiClientHTTP({http.Client? httpClient, 
      this.apiKey = '?',})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  /// The API_key
  final String apiKey;

  static const _baseUrl = 'api.bigoven.com';
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
    final url = Uri.https(
      _baseUrl, 
      _recipeEndPoint,
      queryParameters,
    );
    log('url: $url');

    final response = await _httpClient.get(url, headers: _headers);
    final results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      log('response not 200');
      throw SearchResultError.fromJson(results);
    }
    return SearchResult.fromJson(results);
  }
}
