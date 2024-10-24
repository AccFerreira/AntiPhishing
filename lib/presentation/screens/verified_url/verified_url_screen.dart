import 'package:antiphishing/presentation/widgets/app_bar/antiphishing_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AntiphishingAppBar(),
      body: Container(),
    );
  }
}