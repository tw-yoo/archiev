import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InferenceVisualizer extends StatefulWidget {
  const InferenceVisualizer({super.key});

  @override
  State<StatefulWidget> createState() => _InferenceVisualizerState();
}

class _InferenceVisualizerState extends State<InferenceVisualizer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreenAccent,
      child: Text("inference visualizer",)
    );
  }

}