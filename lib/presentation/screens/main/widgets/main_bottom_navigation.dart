import 'package:antiphishing/presentation/constants/app_colors.dart';
import 'package:antiphishing/presentation/constants/app_svgs.dart';
import 'package:antiphishing/presentation/screens/main/widgets/bottom_navigation_item.dart';
import 'package:antiphishing/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class MainBottomNavigation extends StatelessWidget {
  static const double bottomNavigationHeight = 65;

  final BottomNavigationItem currentItem;
  final void Function(BottomNavigationItem selectedItem) onItemSelected;

  const MainBottomNavigation({
    super.key,
    required this.currentItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final safeAreaBottomOffset = mediaQuery.padding.bottom;

    return Stack(
      children: [
        Container(
          color: AppColors.primaryColor,
          height: safeAreaBottomOffset + bottomNavigationHeight,
        ),
        SizedBox(
          height: bottomNavigationHeight + safeAreaBottomOffset,
          child: BottomNavigationBar(
            backgroundColor: AppColors.primaryColor,
            elevation: 32,
            enableFeedback: false,
            currentIndex: currentItem.index,
            onTap: (index) => onItemSelected(BottomNavigationItem.values[index]),
            items: const [
              BottomNavigationBarItem(
                icon: SvgImage(assetName: AppSvgs.searchBottomIcon, height: 24.0, width: 24.0),
                activeIcon: SvgImage(assetName: AppSvgs.searchBottomIcon, height: 30.0, width: 30.0),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: SvgImage(assetName: AppSvgs.orthographyBottomIcon, height: 24.0, width: 24.0),
                activeIcon: SvgImage(assetName: AppSvgs.orthographyBottomIcon, height: 30.0, width: 30.0),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: SvgImage(assetName: AppSvgs.informationBottomIcon, height: 24.0, width: 24.0),
                activeIcon: SvgImage(assetName: AppSvgs.informationBottomIcon, height: 30.0, width: 30.0),
                label: "",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
