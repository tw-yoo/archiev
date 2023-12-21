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
      return const Text("Image Not Selected\n You should upload image to create chart.", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(256, 256, 256, 100), fontSize: 20),);
    } else {
      return Flexible(
          child: FittedBox(
              fit: BoxFit.cover,
              child: img
          ));
    }
  }

}