import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';

class VisualizeButton extends StatefulWidget {
  const VisualizeButton({super.key});

  @override
  State<StatefulWidget> createState() => VisualizeButtonState();
}

class VisualizeButtonState extends State<VisualizeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: ElevatedButton(
        onPressed: () {

        },
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
        child: const Text("create graph", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}