// import 'dart:ffi';
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

    // bool visualizeGraph = ;
    List<ResultRes> resultResList = context.watch<SelectorOption>().apiResultList;

    if (!context.watch<SelectorOption>().showGraph) {
      return Container(
        child: Text(""),
      );
    } else {

      // 보여줄 데이터 업데이트하기
      List<ChartData> data = [];
      resultResList
          .forEach((resultRes) {
            Iterable<String> resultModelNameList = resultResList.map((e) => e.model_name);

            if (resultModelNameList.contains(resultRes.model_name)) {
              // resultModelNameList가 선택한 model 이름을 가지고 있으면 그래프로 보여줌.

              ResultRes d = resultResList.where((it) => it.model_name == resultRes.model_name).first;

              double emissionSum = d.step1_emission +
                  d.step2_emission + d.step1_emission +
                  d.step4_emission;

              data.add(ChartData(resultRes.model_name, emissionSum));
            }
          });

      List<ChartData> arrangedDataList = context.read<SelectorOption>()
          .arrangeChartDataListByOptions(data);

      double maxY = 1.0;
      if (arrangedDataList.isNotEmpty) {
        maxY = arrangedDataList.map((e) => e.y).reduce(max) * 1.1;
      }
      print("maxY: $maxY");

        return SfCartesianChart(
            title: ChartTitle(
                text: 'Carbon Emission of Selected Model(s)',
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            primaryXAxis: CategoryAxis(
                title: AxisTitle(
                    text: "Model",
                    textStyle: TextStyle(fontWeight: FontWeight.bold)
                ),
              labelStyle: const TextStyle(
                color: Colors.black
              )
            ),
            primaryYAxis: NumericAxis(
                title: AxisTitle(
                    text: "Carbon Emissions (CO2 grams)",
                    textStyle: TextStyle(fontWeight: FontWeight.bold)
                ),
                minimum: 0,
                maximum: maxY,
                interval: maxY * 0.1,
              labelStyle: const TextStyle(
                color: Colors.black
              )
            ),
            tooltipBehavior: _tooltip,
            selectionGesture: ActivationMode.doubleTap,
            onSelectionChanged: (e) {
              String selectedModel = context.read<SelectorOption>().selectedModelOptionList[e.pointIndex];
              context.read<SelectorOption>().setSelectedDetailModel(selectedModel);
              context.read<SelectorOption>().setShowDetailGraph(true);
              // print("clicked selected model option: $selectedDetailModelOption");
            },
            series: <ChartSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                  dataSource: arrangedDataList,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  pointColorMapper: (ChartData data, _) => getChartColor(context, data),
                  // name: 'Kg co2eq for training one hour and inferring 1,000 times',
                  name: '',
                  color: Colors.green,
                  animationDuration: 500
              ),
            ]
    );
    }
  }
}

MaterialColor getChartColor(BuildContext context, ChartData chartData) {

  if (context.watch<SelectorOption>().selectedDetailModel == chartData.x) {
    return Colors.indigo;
  } else {
    return Colors.green;
  }
}