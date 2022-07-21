import 'package:flutter/material.dart';

class CounterProductWidget extends StatelessWidget {
  const CounterProductWidget(
      {required this.quantity,
      required this.addFunction,
      required this.removeFunction})
      : super();
  final int quantity;
  final VoidCallback addFunction;
  final VoidCallback removeFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          TextButton(
              onPressed: addFunction,
              child: Icon(
                Icons.add,
                color: Colors.green,
              )),
          Container(
            alignment: Alignment.center,
            width: 50,
            child: Text(
              quantity.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
              onPressed: removeFunction,
              child: Icon(
                Icons.remove,
                color: Colors.green,
              )),
        ],
      ),
    );
  }
}
