import 'package:flutter/cupertino.dart';

class ModelOption with ChangeNotifier {
  void notify() {notifyListeners();}

  List<String> modelList = [];
  void addModel(String model) { modelList.add(model); }

}