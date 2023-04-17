import 'dart:math';

import 'package:archiev/providers/selector_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/chart_data.dart';

class DetailEmissionVisualizer extends StatefulWidget {
  const DetailEmissionVisualizer({super.key});

  @override
  State<StatefulWidget> createState() => _DetailEmissionVisualizerState();
}

class _DetailEmissionVisualizerState extends State<DetailEmissionVisualizer> {

  late TooltipBehavior _tooltip;
  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ChartData> data = [];

    String selectedDetailModel = context.watch<SelectorOption>().selectedDetailModel;
    bool showDetailGraph = context.watch<SelectorOption>().showDetailGraph;

    if (!showDetailGraph) {
      return Text(selectedDetailModel);
    } else {
      Map resultRes = context.watch<SelectorOption>().apiResultList
          .where((element) => element['model_name'] == selectedDetailModel).first;

      data.add(ChartData("step1", resultRes['step1_emission']));
      data.add(ChartData("step2", resultRes['step2_emission']));
      data.add(ChartData("step3", resultRes['step3_emission']));
      data.add(ChartData("step4", resultRes['step4_emission']));

      double maxY = 1.0;
      if (data.isNotEmpty) {
        maxY = data.map((e) => e.y).reduce(max) * 1.1;
      }

      return SfCartesianChart(
          title: ChartTitle(
              text: selectedDetailModel,
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          ),
          primaryXAxis: CategoryAxis(
              title: AxisTitle(
                  text: "Inference step",
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

    // return Container(
    //   color: Colors.white24,
    //   child: const
    // );
  }

}