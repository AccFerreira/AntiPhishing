import 'package:antiphishing/di/inherited_widget_dependencies.dart';
import 'package:antiphishing/presentation/screens/main/main_bloc.dart';
import 'package:antiphishing/presentation/screens/main/widgets/bottom_navigation_item.dart';
import 'package:antiphishing/presentation/screens/main/widgets/main_bottom_navigation.dart';
import 'package:antiphishing/presentation/screens/navigator/navigators_controller.dart';
import 'package:antiphishing/presentation/screens/verified_url/verified_url_entry.dart';
import 'package:antiphishing/presentation/shared/on_context_ready.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef NavFrameBuilder = Widget Function(Navigator nav);

class MainScreen extends StatefulWidget {
  final NavigatorsController navigatorsController;

  const MainScreen({
    super.key,
    required this.navigatorsController,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with OnContextReady {
  late final bloc = BlocProvider.of<MainBloc>(context);

  @override
  Future<void> onContextReady(BuildContext context) async {
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    final navigatorsController = InheritedWidgetDependencies.of(context).navigatorsController;

    return BlocBuilder<MainBloc, void>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              body: ListenableBuilder(
                listenable: widget.navigatorsController,
                builder: (context, value) {
                  return SizedBox(
                    key: ValueKey(navigatorsController.currentItem.index),
                    child: _buildPageContent(navigatorsController.currentItem),
                  );
                },
              ),
              bottomNavigationBar: MainBottomNavigation(
                onItemSelected: (selectedItem) {
                  setState(() {
                    navigatorsController.setSelectedItem(selectedItem);
                  });
                },
                currentItem: navigatorsController.currentItem,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPageContent(BottomNavigationItem item) {
    switch (item) {
      case BottomNavigationItem.verifiedUrl:
        return const VerifiedUrlEntry();
      case BottomNavigationItem.verifiedText:
        return Container(
          color: Colors.pink,
        );
      case BottomNavigationItem.info:
        return Container(
          color: Colors.yellow,
        );
    }
  }
}
