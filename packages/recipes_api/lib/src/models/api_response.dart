/// {@template API_response}
/// A model of a response from the API API
/// {@endtemplate}
class APIResponse<T> {
  /// {@macro API_response}
  const APIResponse({
    required this.data,
  });

  /// The data responded
  final T data;
}
