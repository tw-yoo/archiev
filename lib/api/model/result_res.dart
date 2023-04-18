import 'dart:convert';
import 'dart:math';

import 'package:archiev/api/model/label_and_prob.dart';

class ResultRes {
  String model_name = "";

  double step1_emission = 0.0;
  double step2_emission = 0.0;
  double step3_emission = 0.0;
  double step4_emission = 0.0;

  double step1_time = 0.0;
  double step2_time = 0.0;
  double step3_time = 0.0;
  double step4_time = 0.0;

  List<LabelAndProb> inference_result = [];

  ResultRes.fromJson(Map<String, dynamic> json) {
    model_name = json['model_name'];

    step1_emission = json['step1_emission'];
    step2_emission = json['step2_emission'];
    step3_emission = json['step3_emission'];
    step4_emission = json['step4_emission'];

    step1_time = json['step1_time'];
    step2_time = json['step2_time'];
    step3_time = json['step3_time'];
    step4_time = json['step4_time'];


    List<LabelAndProb> _tempList = [];
    (json['inference_result'] as List<dynamic>)
        .forEach((element) {
        LabelAndProb labelAndProb = LabelAndProb.fromjson(element);
        _tempList.add(labelAndProb);
    });

    _tempList.sort((a, b) => a.prob.compareTo(b.prob));
    inference_result = _tempList.reversed.toList().sublist(0, min(_tempList.length, 30));


  }
}