import 'package:copy_with_extension/copy_with_extension.dart';

part 'verified_url_state.g.dart';

@CopyWith()
class VerifiedUrlState {
  final bool isLoading;
  final bool isButtonEnabled;

  VerifiedUrlState({
    required this.isLoading,
    required this.isButtonEnabled,
  });
}
