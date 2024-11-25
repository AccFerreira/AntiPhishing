import 'package:antiphishing/domain/verified/repository/verified_repository.dart';
import 'package:antiphishing/domain/verified/use_cases/has_orthography_mistakes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVerifiedRepository extends Mock implements VerifiedRepository {}

void main() {
  late MockVerifiedRepository mockRepository;
  late HasOrthographyMistakes useCase;

  setUp(() {
    mockRepository = MockVerifiedRepository();
    useCase = HasOrthographyMistakes(mockRepository);
  });

  group('HasOrthographyMistakes', () {
    test('should return true when the text has orthography mistakes', () async {
      const text = 'Erros no texto.';
      when(() => mockRepository.hasOrthographyMistakes(text)).thenAnswer((_) async => true);

      final result = await useCase.call(text);

      expect(result, true);
      verify(() => mockRepository.hasOrthographyMistakes(text)).called(1);
    });

    test('should return false when the text has no orthography mistakes', () async {
      const text = 'Texto correto.';
      when(() => mockRepository.hasOrthographyMistakes(text)).thenAnswer((_) async => false);

      final result = await useCase.call(text);

      expect(result, false);
      verify(() => mockRepository.hasOrthographyMistakes(text)).called(1);
    });

    test('should throw exception when repository throws an error', () async {
      const text = 'Texto com erro.';
      when(() => mockRepository.hasOrthographyMistakes(text)).thenThrow(Exception('Unexpected error'));

      expect(() => useCase.call(text), throwsException);
      verify(() => mockRepository.hasOrthographyMistakes(text)).called(1);
    });
  });
}
