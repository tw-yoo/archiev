import 'dart:html';

import 'package:archiev/providers/selector_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


import '../checkbox_list/checkbox_list.dart';
import 'image_box.dart';
import 'image_select_button.dart';

class ImageSelector extends StatefulWidget {

  const ImageSelector({super.key});

  @override
  State<StatefulWidget> createState() => ImageSelectorState();
}

class ImageSelectorState extends State<ImageSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageBox(),
        ImageSelectButton()
      ],
    );
  }
}

void uploadImage(BuildContext context) async {

    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then(
            (value) async {
              await value
                  ?.readAsBytes()
                  .then((byte) {
                    Image img = Image.memory(byte);
                    context.read<SelectorOption>().setImage(img);
                    context.read<SelectorOption>().getGraphUpdateAvailable();
                    context.read<SelectorOption>().setImageByte(byte);
                  }
                  );
            }
            );
}




void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future<PermissionStatus> requestPermissions() async {
  await Permission.photos.request();
  return Permission.photos.status;
}