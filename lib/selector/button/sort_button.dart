import 'package:archiev/providers/selector_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../option/sort_option.dart';

const List<SortOption> options = <SortOption>[SortOption.emission, SortOption.name];

class SortButton extends StatefulWidget {
  const SortButton({super.key});

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {

  String dropdownValue = getSortOptionNameToDisplay(options.first);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: const Text(
            "Order by",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.green),
          underline: Container(
            height: 2,
            color: Colors.green,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
              context.read<SelectorOption>().updateSortOption(dropdownValue);
            });
          },
          items: options.map<DropdownMenuItem<String>>((SortOption option) {

            String sortOptionName = getSortOptionNameToDisplay(option);

            return DropdownMenuItem<String>(
              value: sortOptionName,
              child: Text(sortOptionName),
            );
          }).toList(),
        )
      ],
    );

  }
}