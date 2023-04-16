import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class SelectorOption with ChangeNotifier {

  void notify() { notifyListeners(); }

  // ModelSelector options
  List selectedModelOptionList = [];
  void addModelOption(String option) {
    selectedModelOptionList.add(option);
    notifyListeners();
  }
  void removeModelOption(String option) {
    selectedModelOptionList.remove(option);
    notifyListeners();
  }

  // Image option
  Image? imageData = null;
  void setImage(Image img) {
    imageData = img;
    notifyListeners();
  }

  // show graph
  bool showGraph = false;
  bool getGraphUpdateAvailable() {
    bool modelSelected = selectedModelOptionList.isNotEmpty;
    bool imageSelected = imageData != null;

    if (modelSelected && imageSelected) {
      return true;
    } else {
      return false;
    }
  }

  // 현재 그래프에서 보여주고 있는 모델 리스트
  List<String> currentGraphModelList = [];


  // show detail graph
  bool showDetailGraph = false;

  // DetailEmissionList Options
  List selectedDetailModelList = [];
  void addDetailModel(String model) { selectedDetailModelList.add(model); }
  void removeDetailModel(String model) { selectedDetailModelList.remove(model); }
}