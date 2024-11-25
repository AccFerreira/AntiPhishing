// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verified_orthography_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VerifiedOrthographyStateCWProxy {
  VerifiedOrthographyState isLoading(bool isLoading);

  VerifiedOrthographyState isButtonEnabled(bool isButtonEnabled);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VerifiedOrthographyState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VerifiedOrthographyState(...).copyWith(id: 12, name: "My name")
  /// ````
  VerifiedOrthographyState call({
    bool? isLoading,
    bool? isButtonEnabled,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVerifiedOrthographyState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVerifiedOrthographyState.copyWith.fieldName(...)`
class _$VerifiedOrthographyStateCWProxyImpl implements _$VerifiedOrthographyStateCWProxy {
  const _$VerifiedOrthographyStateCWProxyImpl(this._value);

  final VerifiedOrthographyState _value;

  @override
  VerifiedOrthographyState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  VerifiedOrthographyState isButtonEnabled(bool isButtonEnabled) => this(isButtonEnabled: isButtonEnabled);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VerifiedOrthographyState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VerifiedOrthographyState(...).copyWith(id: 12, name: "My name")
  /// ````
  VerifiedOrthographyState call({
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isButtonEnabled = const $CopyWithPlaceholder(),
  }) {
    return VerifiedOrthographyState(
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      isButtonEnabled: isButtonEnabled == const $CopyWithPlaceholder() || isButtonEnabled == null
          ? _value.isButtonEnabled
          // ignore: cast_nullable_to_non_nullable
          : isButtonEnabled as bool,
    );
  }
}

extension $VerifiedOrthographyStateCopyWith on VerifiedOrthographyState {
  /// Returns a callable class that can be used as follows: `instanceOfVerifiedOrthographyState.copyWith(...)` or like so:`instanceOfVerifiedOrthographyState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VerifiedOrthographyStateCWProxy get copyWith => _$VerifiedOrthographyStateCWProxyImpl(this);
}
