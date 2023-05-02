import 'package:archiev/providers/selector_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ImageBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImageBoxState();

}

class ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Image? img = context.watch<SelectorOption>().imageData;

    if (img == null) {
      return Text("Image Not Selected");
    } else {
      return Container(
        child: img,
      );
    }
  }

}