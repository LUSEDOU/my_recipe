// ignore_for_file: prefer_const_constructors
import 'package:local_storage/src/local_storage.dart';
import 'package:test/test.dart';

void main() {
  group('LocalStorage', () {
    test('can be instantiated', () {
      expect(LocalStorage(), isNotNull);
    });
  });
}
