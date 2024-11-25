import 'package:antiphishing/domain/verified/use_cases/does_url_exists.dart';
import 'package:antiphishing/domain/verified/use_cases/is_a_safe_url.dart';
import 'package:antiphishing/presentation/screens/verified_url/verified_url_bloc.dart';
import 'package:antiphishing/presentation/screens/verified_url/verified_url_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _DoesUrlExistsMock extends Mock implements DoesUrlExists {}

class _IsASafeUrlMock extends Mock implements IsASafeUrl {}

void main() {
  late _DoesUrlExistsMock doesUrlExistsMock;
  late _IsASafeUrlMock isASafeUrlMock;

  VerifiedUrlBloc getBloc({
    _DoesUrlExistsMock? doesUrlExists,
    _IsASafeUrlMock? isASafeUrl,
  }) =>
      VerifiedUrlBloc(
        isASafeUrl ?? _IsASafeUrlMock(),
        doesUrlExists ?? _DoesUrlExistsMock(),
      );

  setUp(() {
    doesUrlExistsMock = _DoesUrlExistsMock();
    isASafeUrlMock = _IsASafeUrlMock();
  });

  group("doesUrlExists", () {
    blocTest<VerifiedUrlBloc, VerifiedUrlState>(
      "should emit [isLoading: true, isLoading: false] and return true if URL exists",
      build: () {
        when(() => doesUrlExistsMock.call(any())).thenAnswer((_) async => true);
        return getBloc(doesUrlExists: doesUrlExistsMock);
      },
      act: (bloc) => bloc.doesUrlExists("https://example.com"),
      expect: () => [
        isA<VerifiedUrlState>().having((state) => state.isLoading, "isLoading", isTrue),
        isA<VerifiedUrlState>().having((state) => state.isLoading, "isLoading", isFalse),
      ],
      verify: (_) {
        verify(() => doesUrlExistsMock.call("https://example.com")).called(1);
      },
    );

    blocTest<VerifiedUrlBloc, VerifiedUrlState>(
      "should emit [isLoading: true, isLoading: false] and return false if URL does not exist",
      build: () {
        when(() => doesUrlExistsMock.call(any())).thenAnswer((_) async => false);
        return getBloc(doesUrlExists: doesUrlExistsMock);
      },
      act: (bloc) => bloc.doesUrlExists("https://nonexistent.com"),
      expect: () => [
        isA<VerifiedUrlState>().having((state) => state.isLoading, "isLoading", isTrue),
        isA<VerifiedUrlState>().having((state) => state.isLoading, "isLoading", isFalse),
      ],
      verify: (_) {
        verify(() => doesUrlExistsMock.call("https://nonexistent.com")).called(1);
      },
    );
  });

  group("isASafeUrl", () {
    blocTest<VerifiedUrlBloc, VerifiedUrlState>(
      "should emit [isLoading: true, isLoading: false] and return true if URL is safe",
      build: () {
        when(() => isASafeUrlMock.call(any())).thenAnswer((_) async => true);
        return getBloc(isASafeUrl: isASafeUrlMock);
      },
      act: (bloc) => bloc.isASafeUrl("https://safe-url.com"),
      expect: () => [
        isA<VerifiedUrlState>().having((state) => state.isLoading, "isLoading", isTrue),
        isA<VerifiedUrlState>().having((state) => state.isLoading, "isLoading", isFalse),
      ],
      verify: (_) {
        verify(() => isASafeUrlMock.call("https://safe-url.com")).called(1);
      },
    );

    blocTest<VerifiedUrlBloc, VerifiedUrlState>(
      "should emit [isLoading: true, isLoading: false] and return false if URL is unsafe",
      build: () {
        when(() => isASafeUrlMock.call(any())).thenAnswer((_) async => false);
        return getBloc(isASafeUrl: isASafeUrlMock);
      },
      act: (bloc) => bloc.isASafeUrl("https://unsafe-url.com"),
      expect: () => [
        isA<VerifiedUrlState>().having((state) => state.isLoading, "isLoading", isTrue),
        isA<VerifiedUrlState>().having((state) => state.isLoading, "isLoading", isFalse),
      ],
      verify: (_) {
        verify(() => isASafeUrlMock.call("https://unsafe-url.com")).called(1);
      },
    );
  });

  group("onDataUpdate", () {
    blocTest<VerifiedUrlBloc, VerifiedUrlState>(
      "should emit [isButtonEnabled: true] when URL is not empty",
      build: () => getBloc(),
      act: (bloc) => bloc.onDataUpdate("https://example.com"),
      expect: () => [
        isA<VerifiedUrlState>().having((state) => state.isButtonEnabled, "isButtonEnabled", isTrue),
      ],
    );

    blocTest<VerifiedUrlBloc, VerifiedUrlState>(
      "should emit [isButtonEnabled: false] when URL is empty",
      build: () => getBloc(),
      seed: () => VerifiedUrlState(isLoading: false, isButtonEnabled: true),
      act: (bloc) => bloc.onDataUpdate(""),
      expect: () => [
        isA<VerifiedUrlState>().having((state) => state.isButtonEnabled, "isButtonEnabled", isFalse),
      ],
    );
  });
}
