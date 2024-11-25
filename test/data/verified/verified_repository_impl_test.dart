import 'dart:async';
import 'dart:convert';

import 'package:antiphishing/data/verified/repositories/verified_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  registerFallbackValue(Uri());
  late VerifiedRepositoryImpl repository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = VerifiedRepositoryImpl(mockHttpClient);
  });

  group('when hasOrthographyMistakes is called,', () {
    const text = "Texto.";
    test('should return false when no mistakes are found', () async {
      final mockResponse = http.Response(
        json.encode({'matches': []}),
        200,
      );

      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => mockResponse);

      final result = await repository.hasOrthographyMistakes(text);

      expect(result, false);
    });

    test('should return true when mistakes are found', () async {
      final mockResponse = http.Response(
        json.encode({
          'matches': [
            {
              'rule': {'id': 'SPELLING'},
              'message': 'Possível erro de ortografia.',
            }
          ]
        }),
        200,
      );

      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => mockResponse);

      final result = await repository.hasOrthographyMistakes(text);

      expect(result, true);
    });

    test('should throw exception on error response', () async {
      final mockResponse = http.Response('Erro', 500);

      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => mockResponse);

      expect(
        () => repository.hasOrthographyMistakes(text),
        throwsException,
      );
    });
  });

  group('when doesUrlExist is called,', () {
    const url = 'https://example.com';

    test('should return true when the URL exists', () async {
      final mockResponse = http.Response('', 200);

      when(() => mockHttpClient.head(any())).thenAnswer((_) async => mockResponse);

      final result = await repository.doesUrlExist(url);

      expect(result, true);
    });

    test('should return null on timeout', () async {
      when(() => mockHttpClient.head(any())).thenThrow(TimeoutException('Timeout'));

      final result = await repository.doesUrlExist(url);

      expect(result, null);
    });

    test('should return null on other errors', () async {
      when(() => mockHttpClient.head(any())).thenThrow(Exception('Erro desconhecido'));

      final result = await repository.doesUrlExist(url);

      expect(result, null);
    });
  });

  group('when isASafeUrls is called,', () {
    final urls = ['https://url.com'];
    test('should return true when all URLs are safe', () async {
      final mockResponse = http.Response(json.encode({}), 200);

      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => mockResponse);

      final result = await repository.isASafeUrls(urls);

      expect(result, true);
    });

    test('should return false when URLs are unsafe', () async {
      final mockResponse = http.Response(
        json.encode({
          'matches': [
            {'threatType': 'MALWARE', 'platformType': 'ANY_PLATFORM', 'threatEntryType': 'URL'}
          ]
        }),
        200,
      );

      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => mockResponse);

      final result = await repository.isASafeUrls(urls);

      expect(result, false);
    });

    test('should return null on timeout', () async {
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenThrow(TimeoutException('Timeout'));

      final result = await repository.isASafeUrls(urls);

      expect(result, null);
    });
  });
}
