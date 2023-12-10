import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  Function(int indice)? evento;

  BottomBar({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      TextButton(
          onPressed: () => evento!(0),
          child: Icon(
            Icons.list, color: Colors.purpleAccent,
          )),
      TextButton(
          onPressed: () => evento!(1),
          child: Icon(Icons.grid_view, color: Colors.purpleAccent)),
    ]);
  }
}
