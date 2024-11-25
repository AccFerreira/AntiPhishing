abstract class VerifiedRepository {
  Future<bool?> isASafeUrls(List<String> urls);
  Future<bool?> doesUrlExist(String url);
  Future<bool> hasOrthographyMistakes(String text);
}
