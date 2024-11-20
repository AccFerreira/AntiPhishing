import 'package:antiphishing/domain/verified/use_cases/does_url_exists.dart';
import 'package:antiphishing/domain/verified/use_cases/is_a_safe_url.dart';
import 'package:antiphishing/presentation/screens/verified_url/verified_url_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifiedUrlBloc extends Cubit<VerifiedUrlState> {
  final IsASafeUrl _isASafeUrl;
  final DoesUrlExists _doesUrlExists;

  VerifiedUrlBloc(
    this._isASafeUrl,
    this._doesUrlExists,
  ) : super(VerifiedUrlState(
          isLoading: false,
          isButtonEnabled: false,
        ));

  Future<bool> doesUrlExists(String url) async {
    emit(state.copyWith(isLoading: true));
    final result = await _doesUrlExists(url);
    emit(state.copyWith(isLoading: false));
    return result;
  }

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
