import 'dart:io';

/// {@template recipes_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class HttpRecipesApi {
  /// {@macro recipes_api}
  const HttpRecipesApi();

  /// Provides a response from the httpApi
  Future<HttpResponse> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  });
}
