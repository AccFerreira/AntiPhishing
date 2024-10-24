import 'package:antiphishing/di/di_setup.dart';
import 'package:antiphishing/di/inherited_widget_dependencies.dart';
import 'package:antiphishing/presentation/constants/app_colors.dart';
import 'package:antiphishing/presentation/screens/main/main_entry.dart';
import 'package:antiphishing/presentation/screens/navigator/navigators_controller.dart';
import 'package:antiphishing/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final navigatorKey = GlobalKey<NavigatorState>();

NavigatorsController _getNavigatorsController() {
  final navigators = getIt<NavigatorsController>();
  return navigators..init();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    configureDependencies();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(MyApp());
  } catch (e) {
    throw Exception("Erro ao inicializar o app: $e");
  }
}

class MyApp extends StatelessWidget {
  final navigatorsController = _getNavigatorsController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return InheritedWidgetDependencies(
      navigatorsController: navigatorsController,
      child: MaterialApp(
        theme: AppTheme.theme,
        color: AppColors.primaryColor,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        home: const MainEntry(),
      ),
    );
  }
}
