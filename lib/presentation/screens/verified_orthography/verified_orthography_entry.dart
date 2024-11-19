import 'package:antiphishing/presentation/screens/verified_orthography/verified_orthography_bloc.dart';
import 'package:antiphishing/presentation/screens/verified_orthography/verified_orthography_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifiedOrthographyEntry extends StatelessWidget {
  static const name = "VerifiedOrthographyEntry";

  const VerifiedOrthographyEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return VerifiedOrthographyBloc(
        )..init();
      },
      child: const VerifiedOrthographyScreen(),
    );
  }
}
