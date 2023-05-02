import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_selector.dart';

class ImageSelectButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImageSelectButtonState();

}

class ImageSelectButtonState extends State<ImageSelectButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: OutlinedButton(
        onPressed: () {
          uploadImage(context);
        },
        // style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
        child: const Text("Click to Upload Image", style: TextStyle(color: Colors.black),),
      ),
    );
  }

}