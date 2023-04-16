import 'package:archiev/visualizer/bottom_visualizer/detail_emission_visualizer.dart';
import 'package:flutter/cupertino.dart';

class BottomVisualizer extends StatefulWidget {
  const BottomVisualizer({super.key});

  @override
  State<StatefulWidget> createState() => _BottomVisualizerState();
}

class _BottomVisualizerState extends State<BottomVisualizer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Flexible(flex: 7, fit: FlexFit.tight, child: DetailEmissionVisualizer()),
      ],
    );
  }

}