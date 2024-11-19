import 'package:antiphishing/domain/verified/repository/verified_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class HasOrthographyMistakes {
  final VerifiedRepository repository;

  HasOrthographyMistakes(this.repository);

  Future<bool> call(String text) async {
    return repository.hasOrthographyMistakes(text);
  }
}
