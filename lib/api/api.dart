import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

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

void getResultResList(BuildContext context, List<String> modelList) {

  Uint8List imageByte = context.watch<SelectorOption>().imageByte!;

  modelList
      .forEach((element) {
        if (!context.watch<SelectorOption>().apiResultList
            .map((e) => e['model_name']).contains(element)) {

          Uri url = Uri.parse("$api_path/test/inference/$element");
          http.post(url, body: imageByte).then((value) {
            context.read<SelectorOption>().addApiResultList(jsonDecode(value.body));
          });

        }});



}