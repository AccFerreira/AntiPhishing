import 'package:antiphishing/domain/verified/repository/verified_repository.dart';
import 'package:antiphishing/domain/verified/use_cases/does_url_exists.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVerifiedRepository extends Mock implements VerifiedRepository {}

void main() {
  late MockVerifiedRepository mockRepository;
  late DoesUrlExists useCase;

  setUp(() {
    mockRepository = MockVerifiedRepository();
    useCase = DoesUrlExists(mockRepository);
  });

  group('DoesUrlExists', () {
    test('should return true when the URL exists', () async {
      const url = 'https://example.com';
      when(() => mockRepository.doesUrlExist(url)).thenAnswer((_) async => true);

      final result = await useCase.call(url);

      expect(result, true);
      verify(() => mockRepository.doesUrlExist(url)).called(1);
    });

    test('should return false when the URL does not exist', () async {
      const url = 'https://nonexistent.com';
      when(() => mockRepository.doesUrlExist(url)).thenAnswer((_) async => false);

      final result = await useCase.call(url);

      expect(result, false);
      verify(() => mockRepository.doesUrlExist(url)).called(1);
    });

    test('should return null when the URL check fails', () async {
      const url = 'https://timeout.com';
      when(() => mockRepository.doesUrlExist(url)).thenAnswer((_) async => null);

      final result = await useCase.call(url);

      expect(result, null);
      verify(() => mockRepository.doesUrlExist(url)).called(1);
    });

    test('should throw exception if the repository throws an error', () async {
      const url = 'https://error.com';
      when(() => mockRepository.doesUrlExist(url)).thenThrow(Exception('Unexpected error'));

      expect(() => useCase.call(url), throwsException);
      verify(() => mockRepository.doesUrlExist(url)).called(1);
    });
  });
}
