import 'package:archiev/visualizer/top_visualizer/top_visualizer.dart';
import 'package:flutter/cupertino.dart';

import 'bottom_visualizer/bottom_visualizer.dart';

class Visualizer extends StatefulWidget {
  const Visualizer({super.key});

  @override
  State<StatefulWidget> createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Flexible(flex: 4, fit: FlexFit.tight, child: TopVisualizer()),
        Flexible(flex: 8, fit: FlexFit.tight, child: BottomVisualizer()),
      ],
    );
  }

}