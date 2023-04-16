import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'checkbox_list/checkbox_list.dart';

class ModelSelector extends StatefulWidget {

const ModelSelector({super.key, selectedDataSet, selectedModelSet});

@override
  State<StatefulWidget> createState() => OptionSelectorState();
}

class OptionSelectorState extends State<ModelSelector> {
@override
Widget build(BuildContext context) {
  return Container(
    color: Colors.white70,
    alignment: Alignment.center,
    child: Column(
      children: const [
        CheckboxList(),
        // const SortButton(),
        // const OrderButton(),
        // VisualizeButton(),
      ],
    ),
  );
}
}