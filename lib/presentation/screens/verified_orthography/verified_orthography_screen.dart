import 'package:antiphishing/presentation/constants/app_colors.dart';
import 'package:antiphishing/presentation/widgets/app_bar/anti_phishing_app_bar.dart';
import 'package:flutter/material.dart';

class VerifiedOrthographyScreen extends StatelessWidget {

  const VerifiedOrthographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AntiPhishingAppBar(),
      body: Container(color: AppColors.grey9E,),
    );
  }
}
