import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:archiev/api/inference_result.dart';
import 'package:archiev/providers/selector_option.dart';
import 'package:archiev/selector/option_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_to_byte/image_to_byte.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import '../providers/model_option.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


import 'model/result_res.dart';

const String api_path = "http://127.0.0.1:8000";

void getModelList(BuildContext context) {
  final url = Uri.parse("$api_path/model_list");
  http.get(url).then(
          (value)  {

            List<String> newData = List<String>.from(json.decode(value.body));
            newData.forEach((element) {
              context.read<ModelOption>().addModel(element);
            });

            context.read<ModelOption>().notify();
          }
  );
}

void updateResultResList(BuildContext context) {

  Uint8List imageByte = context.read<SelectorOption>().imageByte!;

  List<String> modelList = context.read<SelectorOption>().selectedModelOptionList;

  Map<String, Map<String, ResultRes>> resultMap = context.read<InferenceResultProvider>().resultMap;

  context.read<SelectorOption>().emptyApiResultList();

  modelList
      .forEach((model) {

        bool resultMapContainsModel = resultMap.containsKey(model);
        bool resultMapContainsModelAndImage = false;
        if (resultMapContainsModel) {
          if (resultMap[model]!.containsKey(imageByte.toString())) {
            resultMapContainsModelAndImage = true;
          }
        }

        if (resultMapContainsModelAndImage) {
          context.read<SelectorOption>().addApiResultList(
              resultMap[model]![imageByte.toString()]!
          );
        } else {
          // provider check하고  없으면 추가.
          Uri url = Uri.parse("$api_path/test/inference/$model");
          http.post(url, body: imageByte).then((value) {
            dynamic decodedValue = jsonDecode(value.body);
            ResultRes res = ResultRes.fromJson(decodedValue);

            context.read<InferenceResultProvider>().addResultResToResultMap(model, imageByte.toString(), res);
            context.read<SelectorOption>().addApiResultList(res);
          });
        }
      });
}