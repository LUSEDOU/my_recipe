import 'package:recipes_api/recipes_api.dart';

/// {@template recipes_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class HttpRecipesApi {
  /// The url for the HttpApi
  String get baseUrl;

  /// The headers for the request
  Map<String, dynamic> get headers;

  /// Provides a response from the httpApi
  Future<ApiResponse<dynamic>> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  });

}
