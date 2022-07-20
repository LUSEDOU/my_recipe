import 'package:recipes_api/recipes_api.dart';

/// {@template http_response}
/// A model of a response from the BigOven API
/// {@endtemplate}
class HttpResponse<T> implements ApiResponse<T> {
  /// {@macro http_response}
  const HttpResponse({
    required this.data,
  });

  @override
  /// The data responded
  final T data;
}
