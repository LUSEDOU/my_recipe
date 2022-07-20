import 'package:recipes_api/recipes_api.dart';

/// {@template http_exception}
/// Throw if during any process from the API if a failure occurs
/// {endtemplate}
class HttpException implements ApiException{
  /// {@macro http_exception}
  const HttpException({
    this.title = 'HttpException',
    String? message,
  }) : message = message ?? 'An unknown exception ocurred';

  @override
  /// The title for the exceptions
  final String title;

  @override
  /// The message from the error
  final String message;
}
