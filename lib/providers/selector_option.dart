import 'package:flutter/cupertino.dart';

class SelectorOption with ChangeNotifier {
  final List optionList = [];

  void addModelOption(String option ) {
    optionList.add(option);
  }

  void notify() {
    notifyListeners();
  }
}