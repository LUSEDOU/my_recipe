import 'dart:convert';

import 'package:big_oven_api/big_oven_api.dart';
import 'package:local_storage/local_storage.dart';
import 'package:recipes_repository/recipes_repository.dart';

/// Throw if a failure occurs in a getRecipes process
class HttpRepositoryException implements Exception{}


/// {@template recipe_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class HttpRecipesRepository implements RecipeRepository{
  /// {@macro recipe_repository}
  HttpRecipesRepository({
    BigOvenApiClient? httpRecipesApi,
    LocalStorage? localStorageRecipesApi,
    this.apiKey = '?',
  }) : _httpRecipesApi = httpRecipesApi ?? BigOvenApiClient(),
       _localStorageRecipesApi = localStorageRecipesApi ?? LocalStorage();
  
  /// The http Api for the repository
  final BigOvenApiClient _httpRecipesApi;

  /// The cache or local storage for the repository
  final LocalStorage _localStorageRecipesApi;

  /// The key for the api
  final String apiKey;
  
  @override
  /// Get a list of [SearchResult]
  Future<SearchResult> getRecipes(
    String query, {
    int pages = 1,
    bool forceRefresh = false,
  }) async {
    const endPoint = '/recipes';

    final queryParameters = <String, dynamic>{
      'title_kw': query,
      'pg': pages,
      'rpp': 10,
      'api_key': apiKey,
    };

    final cachedResponseData = await getFromCache(
      endPoint,
      queryParameters: queryParameters,
    );

    if (forceRefresh || cachedResponseData != null) {
      final dataJson
          = jsonDecode(cachedResponseData as String) as Map<String, dynamic>;
      
      return SearchResult.fromJson(dataJson);
    }

    try {
      final responseData = await getFromNetwork(
        endPoint,
        queryParameters: queryParameters,
      );
      
      final dataJson 
          = jsonDecode(responseData as String) as Map<String, dynamic>;

      return SearchResult.fromJson(dataJson); 
    } catch (_) {
      throw HttpRepositoryException();
    }
  }

  @override
  Future<dynamic> getFromNetwork(
      String endPoint, {
      Map<String, dynamic>? queryParameters,
  }) async {
    final storageKey = getStorageKey(
      endPoint,
      queryParameters: queryParameters,
    );

    final response = await _httpRecipesApi.get(
      endPoint,
      queryParameters: queryParameters,
    );

    final cacheResponse = CacheResponse(
      data: response.data,
    );

    await _localStorageRecipesApi.write(storageKey, cacheResponse.toJson());

    return response.data;
  }

  @override
  dynamic getFromCache(
      String endPoint, {
      Map<String, dynamic>? queryParameters,
  }) async {
    
    final storageKey = getStorageKey(
      endPoint,
      queryParameters: queryParameters,
    );

    if (_localStorageRecipesApi.has(storageKey)) {
      final rawCachedResponse = _localStorageRecipesApi.get(storageKey);

      final cachedResponse = CacheResponse.fromJson(
        jsonDecode(jsonEncode(rawCachedResponse)) as Map<String, dynamic>,
      );

      return cachedResponse.data;
   } 
  }

  /// Creates a key for the storage
  String getStorageKey(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) {
    var _storageKey = 'GET:${_httpRecipesApi.baseUrl + endPoint}';
    
    if (queryParameters != null) {
      _storageKey += '?';
      queryParameters.forEach((key, value) {
        _storageKey += '$key=$value&';
      });
    }
    return _storageKey;
  }
}
