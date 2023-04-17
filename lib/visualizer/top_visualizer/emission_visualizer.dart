import 'dart:math';

import 'package:archiev/api/model/result_res.dart';
import 'package:archiev/providers/selector_option.dart';
import 'package:archiev/visualizer/model/chart_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../api/api.dart';

class EmissionVisualizer extends StatefulWidget {
  const EmissionVisualizer({super.key});

  @override
  State<StatefulWidget> createState() => _EmissionVisualizerState();
}

class _EmissionVisualizerState extends State<EmissionVisualizer> {

  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    bool visualizeGraph = context.watch<SelectorOption>().getGraphUpdateAvailable();

    if (!visualizeGraph) {
      return Container(
        child: Text(""),
      );
    } else {

      // 현재 선택된 모델리스트
      List<String> selectedModelList = context.watch<SelectorOption>().selectedModelOptionList;
      // api로 데이터 가져오기
      getResultResList(context, selectedModelList);

      // 보여줄 데이터 업데이트하기
      List<ChartData> data = [];
      selectedModelList
          .forEach((element) {
            List<Map> resultResList = context.watch<SelectorOption>().apiResultList;
            Iterable<String> resultModelNameList = resultResList.map((e) => e['model_name']! as String);

            if (resultModelNameList.contains(element)) {
              // resultModelNameList가 선택한 model 이름을 가지고 있으면 그래프로 보여줌.

              Map d = resultResList.where((it) => it['model_name']! == element).first;

              double emissionSum = d['step1_emission'] +
                  d['step2_emission'] + d['step1_emission'] +
                  d['step4_emission'];

              data.add(ChartData(element, emissionSum));
            }
          });

      double maxY = 1.0;
      if (data.isNotEmpty) {
        maxY = data.map((e) => e.y).reduce(max) * 1.1;
      }
        return SfCartesianChart(
            title: ChartTitle(
                text: 'Carbon emission of selected model(s)',
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            primaryXAxis: CategoryAxis(
                title: AxisTitle(
                    text: "Model",
                    textStyle: TextStyle(fontWeight: FontWeight.bold)
                )
            ),
            primaryYAxis: NumericAxis(
                title: AxisTitle(
                    text: "gCO2eq",
                    textStyle: TextStyle(fontWeight: FontWeight.bold)
                ),
                minimum: 0,
                maximum: maxY,
                interval: maxY * 0.1
            ),
            tooltipBehavior: _tooltip,
            selectionGesture: ActivationMode.doubleTap,
            onSelectionChanged: (e) {

              // String selectedArchitecture = context.read<SelectedOptions>().selectedModelList[e.pointIndex];
              //
              // context.read<EmissionManager>()
              //     .updateSelectedArchitecture(
              //     selectedArchitecture
              // );
              // context.read<EmissionManager>()
              //     .updateShowSubChart(true);
            },
            series: <ChartSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                  dataSource: data,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Kg co2eq for training one hour and inferring 1,000 times',
                  color: Color.fromRGBO(8, 142, 255, 1),
                  animationDuration: 500
              ),
            ]);
    }
  }
}