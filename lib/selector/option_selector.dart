import 'package:archiev/selector/button/order_button.dart';
import 'package:archiev/selector/button/sort_button.dart';
import 'package:archiev/selector/image_selector/image_selector.dart';
import 'package:archiev/selector/model_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button/create_graph_button.dart';
import 'checkbox_list/checkbox_list.dart';

class OptionSelector extends StatefulWidget {

const OptionSelector({super.key, selectedDataSet, selectedModelSet});

@override
  State<StatefulWidget> createState() => OptionSelectorState();
}

class OptionSelectorState extends State<OptionSelector> {
@override
Widget build(BuildContext context) {
  return Container(
    color: Colors.white70,
    alignment: Alignment.center,
    child: Column(
      children: [
        const Flexible(flex: 5, fit: FlexFit.tight, child: ModelSelector()),
        const Flexible(flex: 6, fit: FlexFit.tight, child: ImageSelector()),
        Column(
          children: const [
            SortButton(),
            OrderButton(),
            CreateGraphButton()
          ],
        )
      ],
    ),
  );
}
}