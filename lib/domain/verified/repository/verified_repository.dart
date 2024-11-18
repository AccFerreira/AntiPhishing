abstract class VerifiedRepository {
  Future<bool> isASafeUrl(String url);
  Future<bool> hasOrthographyMistakes(String text);
}