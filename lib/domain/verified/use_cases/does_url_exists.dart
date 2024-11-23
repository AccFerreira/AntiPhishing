import 'package:antiphishing/domain/verified/repository/verified_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DoesUrlExists {
  final VerifiedRepository repository;

  DoesUrlExists(this.repository);

  Future<bool?> call(String url) async {
    return repository.doesUrlExist(url);
  }
}
