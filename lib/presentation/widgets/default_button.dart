import 'package:antiphishing/presentation/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;

  const DefaultButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: onTap == null ? AppColors.greyC2 : AppColors.primaryColor,
        overlayColor: AppColors.greyF2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: AppColors.grey9E),
        ),
        minimumSize: const Size(130, 40),
        padding: const EdgeInsets.all(8.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    );
  }
}
