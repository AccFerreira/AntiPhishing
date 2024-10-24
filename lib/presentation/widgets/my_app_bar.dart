import 'package:antiphishing/presentation/constants/app_svgs.dart';
import 'package:antiphishing/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const preferredAppBarSize = Size.fromHeight(56);

  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: AppBar(
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0.0,
        backgroundColor: const Color(0xFF9ACADB),
        title: const SvgImage(assetName: AppSvgs.logoIcon),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => preferredAppBarSize;
}
