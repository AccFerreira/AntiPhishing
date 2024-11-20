import 'package:antiphishing/domain/verified/use_cases/has_orthography_mistakes.dart';
import 'package:antiphishing/presentation/screens/verified_orthography/verified_orthography_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifiedOrthographyBloc extends Cubit<VerifiedOrthographyState> {
  final HasOrthographyMistakes _hasOrthographyMistakes;

  VerifiedOrthographyBloc(this._hasOrthographyMistakes)
      : super(VerifiedOrthographyState(
    isLoading: false,
    isButtonEnabled: false,
  ));

  Future<bool> isASafeOrthography(String text) async {
    emit(state.copyWith(isLoading: true));
    final result = await _hasOrthographyMistakes(text);
    emit(state.copyWith(isLoading: false));
    return !result;
  }

  void onDataUpdate(String text) async {
    final isButtonEnabled = text != "";

    if (isButtonEnabled != state.isButtonEnabled) {
      emit(
        state.copyWith(isButtonEnabled: isButtonEnabled),
      );
    }
  }
}
