import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmissionVisualizer extends StatefulWidget {
  const EmissionVisualizer({super.key});

  @override
  State<StatefulWidget> createState() => _EmissionVisualizerState();
}

class _EmissionVisualizerState extends State<EmissionVisualizer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
      child: Text("emission visualizer"),
    );
  }

}