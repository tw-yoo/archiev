import 'package:archiev/providers/model_option.dart';
import 'package:archiev/providers/selector_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkbox_list/checkbox_list.dart';

class ModelSelector extends StatefulWidget {

  const ModelSelector({super.key, selectedDataSet, selectedModelSet});

  @override
  State<StatefulWidget> createState() => ModelSelectorState();
}

class ModelSelectorState extends State<ModelSelector> {

  String filter = "";
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchTextController
        .addListener(() {
      filter = _searchTextController.text;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List<String> modelList = context.watch<ModelOption>().modelList;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 40),
            child: const Text(
              "Models",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -25),
            child: Container(
              height: 60.0,
              padding: EdgeInsets.only(left: 20, top: 8),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20.0,
                    offset: Offset(0, 10.0),
                  ),
                ],
              ),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _searchTextController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  border: InputBorder.none,
                  hintText: 'Search..',
                ),
              ),
            ),
          ),
          ...modelList
              .toSet().toList()
              .map((String m) {
            return filter == null || filter == ''
                ? SelectCheckBoxItem(
              name: m,
            )
                : m.toLowerCase().contains(filter.toLowerCase())
                ? SelectCheckBoxItem(
              name: m,
            )
                : Container();
          }).toList(),
        ],
      ),
    );
  }
}


// CheckBox
class SelectCheckBoxItem extends StatefulWidget {

  final String name;

  const SelectCheckBoxItem({ Key? key, required this.name}): super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectCheckBoxItemState();
}

class _SelectCheckBoxItemState extends State<SelectCheckBoxItem> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.purpleAccent;
      }
      return Colors.red;
    }

    return CheckboxListTile(
      title: Text(widget.name),
      checkColor: Colors.white,
      // fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {

        if (value == true) {
          context.read<SelectorOption>().addModelOption(widget.name);
        } else {
          context.read<SelectorOption>().removeModelOption(widget.name);
        }

        setState(() {
          isChecked = value!;
        });

        context.read<SelectorOption>().getGraphUpdateAvailable();
      },
    );
  }
}