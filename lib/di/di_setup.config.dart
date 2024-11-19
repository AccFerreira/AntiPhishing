// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:antiphishing/di/navigators_module.dart' as _i533;
import 'package:antiphishing/di/verified_module.dart' as _i801;
import 'package:antiphishing/domain/verified/repository/verified_repository.dart'
    as _i399;
import 'package:antiphishing/domain/verified/use_cases/has_orthography_mistakes.dart'
    as _i623;
import 'package:antiphishing/domain/verified/use_cases/is_a_safe_url.dart'
    as _i546;
import 'package:antiphishing/presentation/screens/navigator/navigators_controller.dart'
    as _i183;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final navigatorModule = _$NavigatorModule();
    final verifiedModule = _$VerifiedModule();
    gh.factory<_i183.NavigatorsController>(
        () => navigatorModule.getNavigatorsController());
    gh.factory<_i399.VerifiedRepository>(
        () => verifiedModule.getVerifiedRepository());
    gh.factory<_i623.HasOrthographyMistakes>(
        () => _i623.HasOrthographyMistakes(gh<_i399.VerifiedRepository>()));
    gh.factory<_i546.IsASafeUrl>(
        () => _i546.IsASafeUrl(gh<_i399.VerifiedRepository>()));
    return this;
  }
}

class _$NavigatorModule extends _i533.NavigatorModule {}

class _$VerifiedModule extends _i801.VerifiedModule {}
