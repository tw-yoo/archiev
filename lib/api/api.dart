import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/model_option.dart';

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