import 'package:antiphishing/presentation/constants/app_text.dart';
import 'package:antiphishing/presentation/constants/app_webp.dart';
import 'package:antiphishing/presentation/widgets/app_bar/anti_phishing_app_bar.dart';
import 'package:antiphishing/presentation/widgets/information_card.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AntiPhishingAppBar(),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InformationCard(
              title: AppText.whatIsPhishing,
              description: AppText.whatIsPhishingDescription,
              imageUrl: AppWebp.phoneAlertIcon,
            ),
            SizedBox(height: 24.0),
            InformationCard(
              title: AppText.howToProtectYourself,
              description: AppText.howToProtectYourselfDescription,
              imageUrl: AppWebp.phoneAndSearchIcon,
            ),
            SizedBox(height: 24.0),
            InformationCard(
              title: AppText.whatMethodsAreUsed,
              description: AppText.whatMethodsAreUsedDescription,
              imageUrl: AppWebp.virusIcon,
            ),
          ],
        ),
      ),
    );
  }
}
