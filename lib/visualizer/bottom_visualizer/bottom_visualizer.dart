import 'package:archiev/visualizer/bottom_visualizer/detail_emission_visualizer.dart';
import 'package:flutter/cupertino.dart';

import '../top_visualizer/inference_visualizer.dart';

class BottomVisualizer extends StatefulWidget {
  const BottomVisualizer({super.key});

  @override
  State<StatefulWidget> createState() => _BottomVisualizerState();
}

class _BottomVisualizerState extends State<BottomVisualizer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Flexible(flex: 7, fit: FlexFit.tight, child: InferenceVisualizer()),
        Flexible(flex: 7, fit: FlexFit.tight, child: DetailEmissionVisualizer()),
      ],
    );
  }

}