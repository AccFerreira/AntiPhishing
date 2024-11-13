import 'package:antiphishing/presentation/screens/verified_url/verified_url_bloc.dart';
import 'package:antiphishing/presentation/screens/verified_url/verified_url_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifiedUrlEntry extends StatelessWidget {
  static const name = "VerifiedUrlEntry";

  const VerifiedUrlEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return VerifiedUrlBloc(
        )..init();
      },
      child: const VerifiedUrlScreen(),
    );
  }
}
