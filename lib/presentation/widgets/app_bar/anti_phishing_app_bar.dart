import 'dart:async';

import 'package:antiphishing/presentation/constants/app_colors.dart';
import 'package:antiphishing/presentation/constants/app_text.dart';
import 'package:antiphishing/presentation/constants/app_webp.dart';
import 'package:flutter/material.dart';

class AntiPhishingAppBar extends StatefulWidget implements PreferredSizeWidget {
  static const preferredAppBarSize = Size.fromHeight(56);
  static const materialKey = Key("Material@AntiphishingAppBar");

  final ScrollController? scrollController;
  final List<Widget>? actions;
  final VoidCallback? onTapReturnButton;

  const AntiPhishingAppBar({
    super.key,
    this.scrollController,
    this.actions,
    this.onTapReturnButton,
  });

  @override
  State<AntiPhishingAppBar> createState() => _AntiPhishingAppBarState();

  @override
  Size get preferredSize => preferredAppBarSize;
}

class _AntiPhishingAppBarState extends State<AntiPhishingAppBar> {
  final StreamController<bool> showElevationController = StreamController<bool>();
  bool _currentShowElevation = false;

  bool get showElevation => _currentShowElevation;

  set showElevation(bool value) {
    showElevationController.add(value);
    _currentShowElevation = value;
  }

  @override
  void initState() {
    widget.scrollController?.addListener(_onScrollChanged);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AntiPhishingAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.scrollController?.removeListener(_onScrollChanged);
    showElevation = false;
    widget.scrollController?.addListener(_onScrollChanged);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScrollChanged);
    showElevationController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: showElevationController.stream,
      builder: (context, snapshot) {
        return Material(
          key: AntiPhishingAppBar.materialKey,
          elevation: 10.0,
          child: AppBar(
            scrolledUnderElevation: 0.0,
            backgroundColor: AppColors.primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppWebp.logoIcon, height: 45.0, width: 45.0),
                const SizedBox(width: 8.0,),
                const Text(
                  AppText.antiPhishing,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            actions: widget.actions,
          ),
        );
      },
    );
  }

  void _onScrollChanged() {
    final offset = widget.scrollController?.position.pixels;
    if (offset != null) {
      if (!showElevation && offset > 0) {
        showElevation = true;
      } else if (showElevation && offset <= 0) {
        showElevation = false;
      }
    }
  }
}
