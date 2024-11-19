import 'package:antiphishing/presentation/constants/app_colors.dart';
import 'package:flutter/material.dart';

class VerificationResultModal extends StatelessWidget {
  final String imageUrl;
  final String text;

  const VerificationResultModal({
    Key? key,
    required this.imageUrl,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.close_rounded,
                  color: AppColors.grey1A,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Image.asset(imageUrl, width: 168, height: 145),
            const SizedBox(height: 16.0),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColors.grey1A,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
