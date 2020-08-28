import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//切换底部导航栏
class CurrentIndexProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  changeIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('currentIndex', _currentIndex));
  }
}
