import 'package:big_oven_api/big_oven_api.dart';
import 'package:dio/dio.dart';
import 'package:recipes_api/recipes_api.dart';

/// {@template big_oven_api_client}
/// Dart Http client which wraps the [BigOven Api](https://api2.bigoven.com/)
/// {@endtemplate}
class BigOvenApiClient implements HttpRecipesApi{  
  
  @override
  /// The BigOven url
  String get baseUrl => 'https://api.bigoven.com';
  
  /// The dio request's options
  Options get options => Options(
    headers: headers,
  );

  @override
  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
  };

  /// The Dio options
  BaseOptions get baseOptions => BaseOptions(
    baseUrl: baseUrl,
    headers: headers,
  );

  /// The Dio package for https calls
  Dio get dio => Dio(baseOptions);

  @override
  /// A get request for the Http, which return a Response
  Future<HttpResponse<dynamic>> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get<String>(
        endPoint,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.statusCode != 200 || response.data == null) {
        throw HttpException(
          title: 'BigOvenApiException',
          message: response.statusMessage,
        );
      }

      final data = response.data.toString();

      return HttpResponse(
        data: data,
      );

    } catch (e) {
      throw HttpException(
        message: e.toString(),
      );
    }
  }
}
