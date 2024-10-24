import 'package:antiphishing/presentation/screens/navigator/navigators_controller.dart';
import 'package:flutter/material.dart';

typedef DependencyConstructor<T> = T Function();

class InheritedWidgetDependencies extends InheritedWidget {
  final NavigatorsController navigatorsController;

  const InheritedWidgetDependencies({super.key, required super.child, required this.navigatorsController});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static InheritedWidgetDependencies of(BuildContext context) {
    final InheritedWidgetDependencies? result =
        context.dependOnInheritedWidgetOfExactType<InheritedWidgetDependencies>();
    assert(result != null, 'No InheritedWidgetDependencies found in context');
    return result!;
  }
}
