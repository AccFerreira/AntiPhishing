import 'package:antiphishing/domain/verified/use_cases/is_a_safe_url.dart';
import 'package:antiphishing/presentation/screens/verified_url/verified_url_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifiedUrlBloc extends Cubit<VerifiedUrlState> {
  final IsASafeUrl _isASafeUrl;

  VerifiedUrlBloc(this._isASafeUrl)
      : super(VerifiedUrlState(
          isLoading: false,
          isButtonEnabled: false,
        ));

  Future<bool> isASafeUrl(String url) async {
    emit(state.copyWith(isLoading: true));
    final result = await _isASafeUrl(url);
    emit(state.copyWith(isLoading: false));
    return result;
  }

  void onDataUpdate(String url) async {
    final isButtonEnabled = url != "";

    if (isButtonEnabled != state.isButtonEnabled) {
      emit(
        state.copyWith(isButtonEnabled: isButtonEnabled),
      );
    }
  }
}
