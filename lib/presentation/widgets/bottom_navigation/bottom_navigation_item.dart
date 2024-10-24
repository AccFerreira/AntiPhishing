import 'package:flutter/material.dart';

enum BottomNavigationItem { home, studentCard }

class RestorableBottomNavigationItem extends RestorableValue<BottomNavigationItem> {
  @override
  BottomNavigationItem createDefaultValue() {
    return BottomNavigationItem.home;
  }

  @override
  BottomNavigationItem fromPrimitives(Object? data) {
    return BottomNavigationItem.values[data as int];
  }

  BottomNavigationItem? get valueOrNull => isRegistered ? value : null;

  @override
  Object? toPrimitives() => value.index;

  @override
  void didUpdateValue(BottomNavigationItem? oldValue) {
    notifyListeners();
  }
}
