import 'package:flutter/material.dart';

class PostCellView extends StatelessWidget {
  final String sText;
  final MaterialColor iColorCode;
  final double dFontSize;
  final int iPosicion;
  final Function(int indice)? onItemListClickedFun;

  const PostCellView(
      {required this.sText,
      required this.iColorCode,
      required this.dFontSize,
      required this.iPosicion,
      required this.onItemListClickedFun});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          color: iColorCode,
          child: Row(
            children: [
              Image.asset('Recursos/aiGenerated.png', width: 55, height: 55),
              Text(sText, style: TextStyle(fontSize: dFontSize)),
              TextButton(
                  onPressed: null,
                  child: Text("-", style: TextStyle(fontSize: dFontSize)))
            ],
          )),
      onTap: () {
        onItemListClickedFun!(iPosicion);
      },
    );
  }
}
