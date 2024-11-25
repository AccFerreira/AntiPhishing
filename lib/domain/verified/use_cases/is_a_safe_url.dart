import 'package:antiphishing/domain/verified/repository/verified_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsASafeUrl {
  final VerifiedRepository repository;

  IsASafeUrl(this.repository);

  Future<bool?> call(String url) async {
    final preparedUrls = generateVariants(url);
    final result = await repository.isASafeUrls(preparedUrls);
    if (result == false) {
      return false;
    }
    return true;
  }

  List<String> generateVariants(String url) {
    final uri = Uri.parse(url.trim());

    final variants = <String>{
      // HTTPS Variants
      Uri(
        scheme: 'https',
        host: uri.host,
        path: uri.path,
        query: uri.query,
      ).toString(),
      Uri(
        scheme: 'https',
        host: 'www.${uri.host}',
        path: uri.path,
        query: uri.query,
      ).toString(),
      Uri(
        scheme: 'https',
        host: uri.host,
        path: uri.path.endsWith('/') ? uri.path : '${uri.path}/',
        query: uri.query,
      ).toString(),
      Uri(
        scheme: 'https',
        host: 'www.${uri.host}',
        path: uri.path.endsWith('/') ? uri.path : '${uri.path}/',
        query: uri.query,
      ).toString(),

      // HTTP Variants
      Uri(
        scheme: 'http',
        host: uri.host,
        path: uri.path,
        query: uri.query,
      ).toString(),
      Uri(
        scheme: 'http',
        host: 'www.${uri.host}',
        path: uri.path,
        query: uri.query,
      ).toString(),
      Uri(
        scheme: 'http',
        host: uri.host,
        path: uri.path.endsWith('/') ? uri.path : '${uri.path}/',
        query: uri.query,
      ).toString(),
      Uri(
        scheme: 'http',
        host: 'www.${uri.host}',
        path: uri.path.endsWith('/') ? uri.path : '${uri.path}/',
        query: uri.query,
      ).toString(),
    };

    return variants.toList();
  }
}
