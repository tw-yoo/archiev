import 'package:archiev/providers/selector_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../option/sort_option.dart';

const List<OrderOption> options = <OrderOption>[ OrderOption.desc, OrderOption.asc];

class OrderButton extends StatefulWidget {
  const OrderButton({super.key});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {

  String dropdownValue = getOrderOptionNameToDisplay(options.first);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
          context.read<SelectorOption>().updateOrderOption(dropdownValue);
        });
      },
      items: options.map<DropdownMenuItem<String>>((OrderOption option) {

        String orderOptionToDisplay = getOrderOptionNameToDisplay(option);

        return DropdownMenuItem<String>(
          value: orderOptionToDisplay,
          child: Text(orderOptionToDisplay),
        );
      }).toList(),
    );
  }
}