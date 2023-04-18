import 'package:flutter/cupertino.dart';

import 'model/result_res.dart';

class InferenceResultProvider with ChangeNotifier {

  // 첫 번째 key: model
  // 두 번째 key: 이미지 byte to string
  Map<String, Map<String, ResultRes>> resultMap = {};

  void addResultResToResultMap(
      String modelName,
      String imageByte,
      ResultRes res
      ) {

    if ( !resultMap.containsKey(modelName) ) {
      resultMap[modelName] = {};
    }

    resultMap[modelName]![imageByte] = res;
    notifyListeners();
  }


}