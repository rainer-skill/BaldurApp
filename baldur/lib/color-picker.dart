import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorSelector extends StatefulWidget {
  final Function(Color, int) setColor;
  final int index;

  ColorSelector(this.setColor, this.index);


  @override
  State<StatefulWidget> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color pickerColor = Color(0xff443a);
  Color currentColor = Color(0xff443a);

    void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void selectColor(Color color) {
    setState(() => currentColor = color);
    widget.setColor(color, widget.index);
  }


  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          showDialog(
              context: context,
              child: Theme(
                  data: Theme.of(context),
                  child: AlertDialog(
                    contentTextStyle: TextStyle(color: Colors.black),
                    title: const Text('Pick a color!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: currentColor,
                        enableAlpha: false,
                        onColorChanged: changeColor,
                        enableLabel: true,
                        pickerAreaHeightPercent: 0.8,
                      ),
                      // Use Material color picker:
                      //
                      // child: MaterialPicker(
                      //   pickerColor: pickerColor,
                      //   onColorChanged: changeColor,
                      //   enableLabel: true, // only on portrait mode
                      // ),
                      //
                      // Use Block color picker:
                      //
                      // child: BlockPicker(
                      //   pickerColor: currentColor,
                      //   onColorChanged: changeColor,
                      // ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: const Text('Got it'),
                        onPressed: () {
                          selectColor(pickerColor);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                  )
                  );
        }, 
        color: currentColor,
        child: null,
      ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
