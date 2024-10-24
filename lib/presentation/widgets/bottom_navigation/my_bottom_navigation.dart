import 'package:antiphishing/presentation/constants/app_svgs.dart';
import 'package:antiphishing/presentation/widgets/bottom_navigation/bottom_navigation_item.dart';
import 'package:antiphishing/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class MyBottomNavigation extends StatelessWidget {
  final BottomNavigationItem currentItem;

  const MyBottomNavigation({
    Key? key,
    required this.currentItem,
    required this.onItemSelected,
  }) : super(key: key);

  static const double bottomNavigationHeight = 56;
  final void Function(BottomNavigationItem selectedItem) onItemSelected;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      top: false,
      child: MediaQuery(
        data: mediaQuery.copyWith(textScaler: TextScaler.noScaling),
        child: SizedBox(
          height: bottomNavigationHeight,
          child: BottomNavigationBar(
            currentIndex: currentItem.index,
            onTap: (index) => onItemSelected(BottomNavigationItem.values[index]),
            items: [
              BottomNavigationBarItem(
                icon: SvgImage(
                  assetName: AppSvgs.searchBottomIcon,
                  height: 24,
                  width: 24,
                  color: Colors.grey[500],
                ),
                activeIcon: const SvgImage(
                  assetName: AppSvgs.searchBottomIcon,
                  height: 24,
                  width: 24,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgImage(
                  assetName: AppSvgs.orthographyIcon,
                  height: 24,
                  width: 24,
                  color: Colors.grey[500],
                ),
                activeIcon: const SvgImage(
                  assetName: AppSvgs.orthographyIcon,
                  height: 24,
                  width: 24,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgImage(
                  assetName: AppSvgs.informationBottomIcon,
                  height: 24,
                  width: 24,
                  color: Colors.grey[500],
                ),
                activeIcon: const SvgImage(
                  assetName: AppSvgs.informationBottomIcon,
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
