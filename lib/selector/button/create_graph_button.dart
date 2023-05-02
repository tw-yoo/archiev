import 'package:archiev/providers/selector_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/api.dart';

class CreateGraphButton extends StatefulWidget {
  const CreateGraphButton({super.key});

  @override
  State<StatefulWidget> createState() => CreateGraphButtonState();
}

class CreateGraphButtonState extends State<CreateGraphButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 30),
      child: ElevatedButton(
        onPressed: () {
          context.read<SelectorOption>().notify();
          context.read<SelectorOption>().setShowGraph(context, true);
          updateResultResList(context);
        },
        child: Text("Create Chart", style: TextStyle(color: Colors.white),),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
      )
    );
  }
}