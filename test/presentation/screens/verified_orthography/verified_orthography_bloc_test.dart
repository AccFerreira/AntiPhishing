import 'package:antiphishing/domain/verified/use_cases/has_orthography_mistakes.dart';
import 'package:antiphishing/presentation/screens/verified_orthography/verified_orthography_bloc.dart';
import 'package:antiphishing/presentation/screens/verified_orthography/verified_orthography_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _HasOrthographyMistakesMock extends Mock implements HasOrthographyMistakes {}

void main() {
  late _HasOrthographyMistakesMock hasOrthographyMistakesMock;

  VerifiedOrthographyBloc getBloc({
    _HasOrthographyMistakesMock? hasOrthographyMistakes,
  }) =>
      VerifiedOrthographyBloc(
        hasOrthographyMistakes ?? _HasOrthographyMistakesMock(),
      );

  setUp(() {
    hasOrthographyMistakesMock = _HasOrthographyMistakesMock();
  });

  group("isASafeOrthography", () {
    blocTest<VerifiedOrthographyBloc, VerifiedOrthographyState>(
      "should emit [isLoading: true, isLoading: false] and return true when no mistakes are found",
      build: () {
        when(() => hasOrthographyMistakesMock.call(any())).thenAnswer((_) async => false);
        return getBloc(hasOrthographyMistakes: hasOrthographyMistakesMock);
      },
      act: (bloc) => bloc.isASafeOrthography("Texto correto."),
      expect: () => [
        isA<VerifiedOrthographyState>().having((state) => state.isLoading, "isLoading", isTrue),
        isA<VerifiedOrthographyState>().having((state) => state.isLoading, "isLoading", isFalse),
      ],
      verify: (_) {
        verify(() => hasOrthographyMistakesMock.call("Texto correto.")).called(1);
      },
    );

    blocTest<VerifiedOrthographyBloc, VerifiedOrthographyState>(
      "should emit [isLoading: true, isLoading: false] and return false when mistakes are found",
      build: () {
        when(() => hasOrthographyMistakesMock.call(any())).thenAnswer((_) async => true);
        return getBloc(hasOrthographyMistakes: hasOrthographyMistakesMock);
      },
      act: (bloc) => bloc.isASafeOrthography("Texto errado"),
      expect: () => [
        isA<VerifiedOrthographyState>().having((state) => state.isLoading, "isLoading", isTrue),
        isA<VerifiedOrthographyState>().having((state) => state.isLoading, "isLoading", isFalse),
      ],
      verify: (_) {
        verify(() => hasOrthographyMistakesMock.call("Texto errado")).called(1);
      },
    );
  });

  group("onDataUpdate", () {
    blocTest<VerifiedOrthographyBloc, VerifiedOrthographyState>(
      "should emit [isButtonEnabled: true] when text is not empty",
      build: () => getBloc(hasOrthographyMistakes: hasOrthographyMistakesMock),
      act: (bloc) => bloc.onDataUpdate("Texto preenchido"),
      expect: () => [
        isA<VerifiedOrthographyState>().having((state) => state.isButtonEnabled, "isButtonEnabled", isTrue),
      ],
    );

    blocTest<VerifiedOrthographyBloc, VerifiedOrthographyState>(
      "should emit [isButtonEnabled: false] when text is empty",
      build: () => getBloc(hasOrthographyMistakes: hasOrthographyMistakesMock),
      seed: () => VerifiedOrthographyState(isLoading: false, isButtonEnabled: true),
      act: (bloc) => bloc.onDataUpdate(""),
      expect: () => [
        isA<VerifiedOrthographyState>().having((state) => state.isButtonEnabled, "isButtonEnabled", isFalse),
      ],
    );
  });
}
