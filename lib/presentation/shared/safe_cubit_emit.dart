import 'package:flutter_bloc/flutter_bloc.dart';

mixin SafeCubitEmitMixin<T> on Cubit<T> {
  @override
  void emit(state) {
    if (isClosed) {
      return;
    }
    super.emit(state);
  }
}
