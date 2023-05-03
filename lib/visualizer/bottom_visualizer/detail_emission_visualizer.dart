import 'dart:math';

import 'package:archiev/providers/selector_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../api/model/result_res.dart';
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
    _tooltip = TooltipBehavior(
        enable: false,
    );
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
      Iterable<ResultRes> resultResIter = context.watch<SelectorOption>().apiResultList
          .where((element) => element.model_name == selectedDetailModel);

      if (resultResIter.isEmpty) {
        return const Text("");
      } else {


        ResultRes resultRes = resultResIter.first;

        double emissionSum = resultRes.step1_emission + resultRes.step2_emission
            + resultRes.step3_emission + resultRes.step4_emission;

        data.add(ChartData("step1", 100 * resultRes.step1_emission  / emissionSum));
        data.add(ChartData("step2", 100 * resultRes.step2_emission / emissionSum));
        data.add(ChartData("step3", 100 * resultRes.step3_emission / emissionSum));
        data.add(ChartData("step4", 100 * resultRes.step4_emission / emissionSum));

        double maxY = 100;
        // if (data.isNotEmpty) {
        //   maxY = data.map((e) => e.y).reduce(max) * 1.1;
        // }

        return SfCartesianChart(
            title: ChartTitle(
                text: selectedDetailModel,
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            primaryXAxis: CategoryAxis(
              majorGridLines: null,
                majorTickLines: MajorTickLines(width: 0),
                title: AxisTitle(
                    text: "Model Inference Step",
                    textStyle: TextStyle(fontWeight: FontWeight.bold)
                ),
              labelStyle: const TextStyle(
                color: Colors.black
              )
            ),
            primaryYAxis: NumericAxis(
              isVisible: false, // Hide Y-axis
              majorGridLines: null, // Remove horizontal lines
              majorTickLines: MajorTickLines(width: 0), // Remove tick marks
            ),
            // NumericAxis(
            //   isVisible: false,
            //     title: AxisTitle(
            //         text: "Carbon Emissions",
            //         textStyle: TextStyle(fontWeight: FontWeight.bold)
            //     ),
            //     minimum: 0,
            //     maximum: maxY,
            //     interval: maxY * 0.1,
            //   labelStyle: const TextStyle(
            //     color: Colors.black
            //   )
            // ),

            tooltipBehavior: _tooltip,
            series: <ChartSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                  dataSource: data,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  color: Colors.green,
                  animationDuration: 500,
                dataLabelMapper: (ChartData data, _) => "${getStep(data.x)} \n ${data.y.toStringAsFixed(2)}%",
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.outer,
                  color: Colors.black,
                ),
              ),
            ]);

      }
      }

    // return Container(
    //   color: Colors.white24,
    //   child: const
    // );
  }

}

String getStep(String step) {
  if (step == "step1") {
    return "Convert Byte \n to Image Object";
  } else if (step == "step2") {
    return "Load Model";
  } else if (step == "step3") {
    return "Resize Image";
  } else if (step == "step4") {
    return "Inference";
  } else {
    return "";
  }
}