import 'package:archiev/visualizer/top_visualizer/emission_visualizer.dart';
import 'package:archiev/visualizer/top_visualizer/inference_visualizer.dart';
import 'package:flutter/cupertino.dart';

class TopVisualizer extends StatefulWidget {
  const TopVisualizer({super.key});

  @override
  State<StatefulWidget> createState() => _TopVisualizerState();
}

class _TopVisualizerState extends State<TopVisualizer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Flexible(flex: 7, fit: FlexFit.tight, child: EmissionVisualizer()),
      ],
    );
  }

}