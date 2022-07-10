// ignore_for_file: prefer_const_constructors
import 'package:big_oven_api/big_oven_api.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response<dynamic> {}

void main() {
  group('BigOvenApiClient', () {
    late Dio dio;
    late BigOvenApiClient bigOvenApiClient;

    test('can be instantiated', () {
      expect(BigOvenApiClient, isNotNull);
    });

    setUp(() {
      dio = MockDio();
      bigOvenApiClient = BigOvenApiClient(
        dio: dio, 
      );
    });

    group('constructor', () {
      test('does not require a Dio', () {
        expect(BigOvenApiClient(apiKey: 'mockApiKey'), isNotNull);
      });

      test('does not requires an apiKey', () {
        expect(BigOvenApiClient(dio: dio), isNotNull);
      });

      test('does not requires anything', () {
        expect(BigOvenApiClient(), isNotNull);
      });
    });

    group('search', () {
      const query = 'mock-query';
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn('[]');
        when(() => dio.get<dynamic>(any())).thenAnswer((_) async => response);
        try {
          await bigOvenApiClient.search(query: query);
        } catch (_) {}
        verify(
          () => dio.get<dynamic>(
            '/recipe',
            queryParameters: {
              'title_kw': query, 'pg': 1, 'rpp': 10, 'api_key': '?',
            },
            options: Options(headers: {'content-Type': 'application/json'}),
          ),
        );
      });
    });

  });
}
