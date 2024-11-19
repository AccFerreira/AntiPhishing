import 'package:antiphishing/presentation/constants/app_colors.dart';
import 'package:antiphishing/presentation/constants/app_text.dart';
import 'package:antiphishing/presentation/constants/app_webp.dart';
import 'package:antiphishing/presentation/widgets/app_bar/anti_phishing_app_bar.dart';
import 'package:antiphishing/presentation/widgets/default_button.dart';
import 'package:antiphishing/presentation/widgets/information_card.dart';
import 'package:flutter/material.dart';

class VerifiedUrlScreen extends StatefulWidget {
  const VerifiedUrlScreen({super.key});

  @override
  State<VerifiedUrlScreen> createState() => _VerifiedUrlScreenState();
}

class _VerifiedUrlScreenState extends State<VerifiedUrlScreen> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AntiPhishingAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                AppText.insertUrl,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.grey1A, fontSize: 20.0),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Image.asset(AppWebp.searchIcon, width: 45, height: 45),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        hintText: AppText.pasteUrl,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                      ),
                      keyboardType: TextInputType.url,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              DefaultButton(
                onTap: () {},
                text: AppText.sendUrl,
              ),
              const SizedBox(height: 16.0),
              const InformationCard(
                title: AppText.warning,
                description: AppText.warningUrl,
                imageUrl: AppWebp.alertIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
