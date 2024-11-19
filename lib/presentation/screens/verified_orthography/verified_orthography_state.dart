import 'package:copy_with_extension/copy_with_extension.dart';

part 'verified_orthography_state.g.dart';

@CopyWith()
class VerifiedOrthographyState {
  final bool isLoading;
  final bool isButtonEnabled;

  VerifiedOrthographyState({
    required this.isLoading,
    required this.isButtonEnabled,
  });
}
