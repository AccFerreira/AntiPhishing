import 'package:antiphishing/domain/verified/repository/verified_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsASafeUrl {
  final VerifiedRepository repository;

  IsASafeUrl(this.repository);

  Future<bool> call(String url) async {
    return repository.isASafeUrl(url);
  }
}
