/// {@template http_exception}
/// Throw if during any process from the API if a failure occurs
/// {endtemplate}
class APIException implements Exception {
  /// {@macro http_exception}
  const APIException({
    required this.title,
    this.message = 'An unknown exception ocurred',
  });

/// The title for the exceptions
  final String title;

  /// The message from the error
  final String message;
}
