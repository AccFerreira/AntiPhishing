// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verified_url_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VerifiedUrlStateCWProxy {
  VerifiedUrlState isLoading(bool isLoading);

  VerifiedUrlState isButtonEnabled(bool isButtonEnabled);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VerifiedUrlState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VerifiedUrlState(...).copyWith(id: 12, name: "My name")
  /// ````
  VerifiedUrlState call({
    bool? isLoading,
    bool? isButtonEnabled,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVerifiedUrlState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVerifiedUrlState.copyWith.fieldName(...)`
class _$VerifiedUrlStateCWProxyImpl implements _$VerifiedUrlStateCWProxy {
  const _$VerifiedUrlStateCWProxyImpl(this._value);

  final VerifiedUrlState _value;

  @override
  VerifiedUrlState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  VerifiedUrlState isButtonEnabled(bool isButtonEnabled) =>
      this(isButtonEnabled: isButtonEnabled);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VerifiedUrlState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VerifiedUrlState(...).copyWith(id: 12, name: "My name")
  /// ````
  VerifiedUrlState call({
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isButtonEnabled = const $CopyWithPlaceholder(),
  }) {
    return VerifiedUrlState(
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      isButtonEnabled: isButtonEnabled == const $CopyWithPlaceholder() ||
              isButtonEnabled == null
          ? _value.isButtonEnabled
          // ignore: cast_nullable_to_non_nullable
          : isButtonEnabled as bool,
    );
  }
}

extension $VerifiedUrlStateCopyWith on VerifiedUrlState {
  /// Returns a callable class that can be used as follows: `instanceOfVerifiedUrlState.copyWith(...)` or like so:`instanceOfVerifiedUrlState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VerifiedUrlStateCWProxy get copyWith => _$VerifiedUrlStateCWProxyImpl(this);
}
