import 'package:antiphishing/presentation/screens/main/widgets/bottom_navigation_item.dart';
import 'package:flutter/material.dart';

class NavigatorsController extends ChangeNotifier {
  BottomNavigationItem currentItem = BottomNavigationItem.verifiedUrl;

  void setSelectedItem(BottomNavigationItem selectedItem) {
    if (currentItem != selectedItem) {
      currentItem = selectedItem;
      notifyListeners();
    }
  }

  void init() {
    notifyListeners();
  }
}
