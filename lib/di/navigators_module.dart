import 'package:antiphishing/presentation/screens/navigator/navigators_controller.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NavigatorModule {
  static NavigatorsController? _navigatorsController;

  NavigatorsController getNavigatorsController() {
    final cached = _navigatorsController;
    if (cached != null) {
      return cached;
    }
    final newInstance = NavigatorsController();
    _navigatorsController = newInstance;
    return newInstance;
  }
}
