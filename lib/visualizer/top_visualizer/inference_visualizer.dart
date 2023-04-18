import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';


import '../../api/model/result_res.dart';
import '../../providers/selector_option.dart'; // Listener 사용을 위해 'gestures.dart' import.


class InferenceVisualizer extends StatefulWidget {
  const InferenceVisualizer({super.key});

  @override
  State<StatefulWidget> createState() => _InferenceVisualizerState();
}

class _InferenceVisualizerState extends State<InferenceVisualizer> {

  final ScrollController _scrollController = ScrollController(); // 컨트롤러 선언.

  List<String> tempList = [];

  @override
  Widget build(BuildContext context) {

    bool showDetailGraph = context.watch<SelectorOption>().showDetailGraph;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (!showDetailGraph) {
      return Text("");
    } else {

      String selectedDetailModel = context.watch<SelectorOption>().selectedDetailModel;
      List<ResultRes> resultResList = context.watch<SelectorOption>().apiResultList;

      ResultRes selectedDetailResult = resultResList
          .where(
              (element) => element.model_name == selectedDetailModel
      ).first;

      Map inferenceResult = selectedDetailResult.inference_result;
      List<dynamic> l = inferenceResult.keys.toList();

      return
        Container(
        margin: EdgeInsets.fromLTRB(50, screenHeight * 0.05, 50, screenHeight * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Text("Results", style: TextStyle(fontSize: 20,),textAlign: TextAlign.left,),
              ),
              ...l
                  .map((e) {
                return Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: [
                      Text(
                        "$e",
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        children: [
                          LinearPercentIndicator(
                            percent: inferenceResult[e],
                            backgroundColor: Colors.grey,
                            progressColor: Colors.orange,
                            width: 200,
                          ),
                          Text(" ${inferenceResult[e]}")
                        ],
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      );
    }
  }

}
