import 'package:antiphishing/domain/verified/repository/verified_repository.dart';
import 'package:antiphishing/domain/verified/use_cases/is_a_safe_url.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVerifiedRepository extends Mock implements VerifiedRepository {}

void main() {
  late MockVerifiedRepository mockRepository;
  late IsASafeUrl useCase;

  setUp(() {
    mockRepository = MockVerifiedRepository();
    useCase = IsASafeUrl(mockRepository);
  });

  group('IsASafeUrl', () {
    const url = 'example.com';

    test('should generate correct URL variants', () {
      String modifiedUrl = url;
      if (!url.trim().startsWith("http://") && !url.trim().startsWith("https://")) {
        modifiedUrl = "http://$url";
      }
      final variants = useCase.generateVariants(modifiedUrl);

      expect(variants, contains('https://example.com'));
      expect(variants, contains('https://www.example.com'));
      expect(variants, contains('http://example.com'));
      expect(variants, contains('http://www.example.com'));
      expect(variants, contains('https://example.com/'));
      expect(variants, contains('https://www.example.com/'));
      expect(variants, contains('http://example.com/'));
      expect(variants, contains('http://www.example.com/'));
    });

    test('should return true when URLs are safe', () async {
      String modifiedUrl = url;
      if (!url.trim().startsWith("http://") && !url.trim().startsWith("https://")) {
        modifiedUrl = "http://$url";
      }
      final preparedUrls = useCase.generateVariants(modifiedUrl);

      when(() => mockRepository.isASafeUrls(preparedUrls)).thenAnswer((_) async => true);

      final result = await useCase.call(url);

      expect(result, true);
      verify(() => mockRepository.isASafeUrls(preparedUrls)).called(1);
    });

    test('should return false when URLs are not safe', () async {
      String modifiedUrl = url;
      if (!url.trim().startsWith("http://") && !url.trim().startsWith("https://")) {
        modifiedUrl = "http://$url";
      }
      final preparedUrls = useCase.generateVariants(modifiedUrl);

      when(() => mockRepository.isASafeUrls(preparedUrls)).thenAnswer((_) async => false);

      final result = await useCase.call(url);

      expect(result, false);
      verify(() => mockRepository.isASafeUrls(preparedUrls)).called(1);
    });

    test('should return null when repository fails', () async {
      String modifiedUrl = url;
      if (!url.trim().startsWith("http://") && !url.trim().startsWith("https://")) {
        modifiedUrl = "http://$url";
      }
      final preparedUrls = useCase.generateVariants(modifiedUrl);

      when(() => mockRepository.isASafeUrls(preparedUrls)).thenAnswer((_) async => null);

      final result = await useCase.call(url);

      expect(result, null);
      verify(() => mockRepository.isASafeUrls(preparedUrls)).called(1);
    });

    test('should throw exception if repository throws an error', () async {
      String modifiedUrl = url;
      if (!url.trim().startsWith("http://") && !url.trim().startsWith("https://")) {
        modifiedUrl = "http://$url";
      }
      final preparedUrls = useCase.generateVariants(modifiedUrl);

      when(() => mockRepository.isASafeUrls(preparedUrls)).thenThrow(Exception('Unexpected error'));

      expect(() => useCase.call(url), throwsException);
      verify(() => mockRepository.isASafeUrls(preparedUrls)).called(1);
    });
  });
}
