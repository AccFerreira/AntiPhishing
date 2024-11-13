import 'package:antiphishing/presentation/constants/app_colors.dart';
import 'package:antiphishing/presentation/constants/app_text.dart';
import 'package:antiphishing/presentation/constants/app_webp.dart';
import 'package:antiphishing/presentation/screens/main/widgets/bottom_navigation_item.dart';
import 'package:flutter/material.dart';

class MainBottomNavigation extends StatelessWidget {
  static const double bottomNavigationHeight = 70;

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
            selectedLabelStyle: const TextStyle(fontSize: 12.0, color: AppColors.white, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontSize: 12.0, color: AppColors.white),
            backgroundColor: AppColors.primaryColor,
            elevation: 15,
            useLegacyColorScheme: false,
            currentIndex: currentItem.index,
            onTap: (index) => onItemSelected(BottomNavigationItem.values[index]),
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(AppWebp.searchIcon ,height: 35.0, width: 35.0),
                label: AppText.verifiedUrl,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppWebp.orthographyIcon ,height: 35.0, width: 35.0),
                label: AppText.verifiedText,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppWebp.informationIcon ,height: 35.0, width: 35.0),
                label: AppText.information,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
