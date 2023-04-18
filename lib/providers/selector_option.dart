import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import '../api/api.dart';
import '../api/model/result_res.dart';
import '../selector/option/sort_option.dart';
import '../visualizer/model/chart_data.dart';

class SelectorOption with ChangeNotifier {

  void notify() { notifyListeners(); }

  // ModelSelector options
  // sorting 옵션 추가되면 여기 수정해야 함.
  List<String> selectedModelOptionList = [];
  void addModelOption(String option) {
    selectedModelOptionList.add(option);
    print("add option: $selectedModelOptionList");
    notifyListeners();
  }
  void removeModelOption(String option) {
    selectedModelOptionList.remove(option);
    print("remove option: $selectedModelOptionList");
    notifyListeners();
  }

  // Image option
  Image? imageData = null;
  void setImage(Image img) {
    imageData = img;
    notifyListeners();
  }

  Uint8List? imageByte;
  void setImageByte(Uint8List b) {
    imageByte = b;
    notifyListeners();
  }

  // api에서 가져온 결과 저장하는 리스트.
  // 탄소배출량 보여줄 때 여기셔 가져다 씀.
  List<ResultRes> apiResultList = [];
  void addApiResultList(ResultRes d) {
    apiResultList.add(d);
    notifyListeners();
  }
  void emptyApiResultList() {
    apiResultList = [];
    notifyListeners();
  }

  List<ChartData> arrangeChartDataListByOptions(List<ChartData> originList) {

    List<ChartData> listSortedBySortOption = [];
    if (selectedSortOption == SortOption.name) {
      originList.sort((a, b) =>
          a.x.toLowerCase().compareTo(b.x.toLowerCase())
      );
      listSortedBySortOption = originList;
    } else if (selectedSortOption == SortOption.emission) {
      originList.sort((a, b) =>
          a.y.compareTo(b.y)
      );
      listSortedBySortOption = originList;
    }

    if (selectedOrderOption == OrderOption.asc) {
      listSortedBySortOption = listSortedBySortOption;
    } else if (selectedOrderOption == OrderOption.desc) {
      listSortedBySortOption = listSortedBySortOption.reversed.toList();
    } else {
      listSortedBySortOption = listSortedBySortOption;
    }

    selectedModelOptionList = listSortedBySortOption.map((e) => e.x).toList();

    return listSortedBySortOption;
  }

  SortOption selectedSortOption = SortOption.emission;
  OrderOption selectedOrderOption = OrderOption.desc;
  void updateSortOption(String option) {
    if (option == "Name") {
      selectedSortOption = SortOption.name;
    } else if (option == "Carbon Emission") {
      selectedSortOption = SortOption.emission;
    }
  }

  void updateOrderOption(String option) {
    if (option == "Ascending") {
      selectedOrderOption = OrderOption.asc;
    } else if (option == "Descending") {
      selectedOrderOption = OrderOption.desc;
    }
  }


  // show graph
  bool showGraph = false;
  void setShowGraph(BuildContext context, bool b) {
    showGraph = b;
    notifyListeners();
  }

  // 현재 그래프에서 보여주고 있는 모델 리스트
  List<String> currentGraphModelList = [];


  // show detail graph
  bool showDetailGraph = false;
  void setShowDetailGraph(bool b) {
    showDetailGraph = b;
    notifyListeners();
  }

  // selected detail graph option
  String selectedDetailModel = "";
  void setSelectedDetailModel(String m) {
    selectedDetailModel = m;
    notifyListeners();
  }

  // DetailEmissionList Options
  List selectedDetailModelList = [];
  void addDetailModel(String model) { selectedDetailModelList.add(model); }
  void removeDetailModel(String model) { selectedDetailModelList.remove(model); }
}