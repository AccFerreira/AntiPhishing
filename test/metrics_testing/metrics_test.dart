import 'package:antiphishing/data/verified/repositories/verified_repository_impl.dart';
import 'package:antiphishing/domain/verified/use_cases/is_a_safe_url.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'urls_for_testing.dart';

double calculateMean(List<double> values) {
  return values.reduce((a, b) => a + b) / values.length;
}

void main() {
  group('URL Detection Tests', () {
    test('Calculate Metrics', () async {
      final verifiedRepositoryImpl = VerifiedRepositoryImpl();
      final isASafeUrl = IsASafeUrl(verifiedRepositoryImpl);
      List<double> responseTimes = [];
      int correctDetections = 0; // URLs classificadas corretamente
      int falsePositives = 0; // URLs seguras classificadas como phishing
      int falseNegatives = 0; // URLs phishing classificadas como seguras

      for (var test in urlsForTesting) {
        final startTime = DateTime.now();
        final result = await isASafeUrl(test['url']!);
        final endTime = DateTime.now();

        responseTimes.add(endTime.difference(startTime).inMilliseconds.toDouble());

        final expected = !(test['isPhishing'] == "true");

        if (result != null) {
          if (result == expected) {
            correctDetections++;
          } else if (result && !expected) {
            falseNegatives++;
          } else if (!result && expected) {
            falsePositives++;
          }
        }

        if (kDebugMode) {
          print("URL: ${test['url']!}");
          print(
            "Result: ${(result != null ? (!result).toString() : "null")} =============== Expect: ${test['isPhishing']}",
          );
        }
      }

      final accuracy = (correctDetections / urlsForTesting.length) * 100;
      final meanResponseTime = calculateMean(responseTimes);

      if (kDebugMode) {
        print("\n=================== RESULTADOS DAS MÉTRICAS ===================\n");
        print('Acurácia: ${accuracy.toStringAsFixed(2)}%');
        print('Falsos Positivos: ${((falsePositives / urlsForTesting.length) * 100).toStringAsFixed(2)}');
        print('Falsos Negativos: ${((falseNegatives / urlsForTesting.length) * 100).toStringAsFixed(2)}');
        print('Média do Tempo de Resposta: ${meanResponseTime.toStringAsFixed(2)}ms');
      }
      expect(accuracy, greaterThanOrEqualTo(80.0), reason: 'Acurácia acima de 80%');
    });
  });
}
