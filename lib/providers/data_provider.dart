import 'package:flutter/cupertino.dart';

import '../api/model/result_res.dart';
import '../visualizer/model/chart_data.dart';

class DataProvider with ChangeNotifier {

  List<ResultRes> resultResList = [];
  void addResult(ResultRes res) {
    resultResList.add(res);
    notifyListeners();
  }
  void removeResult(ResultRes res) {
    resultResList.removeWhere((element) => element.model_name == res.model_name);
    notifyListeners();
  }

  List<ChartData> mainChartDataList = [];
  void addMainChartData(ChartData data) {
    mainChartDataList.add(data);
    notifyListeners();
  }
  void removeChartData(ChartData data) {
    mainChartDataList.removeWhere((element) => element.x == data.x);
    notifyListeners();
  }

}