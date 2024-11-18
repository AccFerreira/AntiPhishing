import 'package:antiphishing/domain/verified/repository/verified_repository.dart';

class CheckUrlSafety {
  final VerifiedRepository repository;

  CheckUrlSafety(this.repository);

  Future<bool> call(String url) {
    return repository.isASafeUrl(url);
  }
}
