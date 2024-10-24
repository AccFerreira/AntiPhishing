import 'package:antiphishing/di/inherited_widget_dependencies.dart';
import 'package:antiphishing/presentation/screens/main/main_bloc.dart';
import 'package:antiphishing/presentation/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainEntry extends StatelessWidget {
  static const name = "MainEntry";

  const MainEntry({super.key});

  @override
  Widget build(BuildContext context) {
    late final navigatorsController = InheritedWidgetDependencies.of(context).navigatorsController;

    return BlocProvider(
      create: (context) {
        return MainBloc();
      },
      child: MainScreen(
        navigatorsController: navigatorsController,
      ),
    );
  }
}
