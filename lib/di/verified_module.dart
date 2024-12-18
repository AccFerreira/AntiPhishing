import 'package:antiphishing/data/verified/repositories/verified_repository_impl.dart';
import 'package:antiphishing/domain/verified/repository/verified_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@module
abstract class VerifiedModule {
  VerifiedRepository getVerifiedRepository() {
    return VerifiedRepositoryImpl(http.Client());
  }
}
