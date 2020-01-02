import 'dart:convert';

import 'package:baldur/color-picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baldur',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          backgroundColor: Color.fromRGBO(25, 25, 25, 1),
          primaryColor: Colors.white,
          textTheme: TextTheme()),
      home: MyHomePage(title: 'Baldur'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = 'http://192.168.2.107:5000';

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  List<Color> colors = new List(3).map((val) => Color(0xff443a49)).toList();

  void setColor(Color color, int index) {
    // colors.removeAt(index);
    // colors.insert(index, color);
    colors[index] = color;
    List<Object> jsonColors = colors.map((val) => ({'R': val.red, 'G': val.green, 'B': val.blue})).toList();
    http.post('$url/colors',
        body: jsonEncode({"colors": jsonColors}),
        headers: {'Content-Type': 'application/json'});
  }

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void selectColor(Color color) {
    setState(() => currentColor = color);
    Object colors = {'R': color.red, 'G': color.green, 'B': color.blue};
    http.post('$url/colors',
        body: jsonEncode(colors),
        headers: {'Content-Type': 'application/json'});
  }

  @override
  Widget build(BuildContext context) {
    // create some values
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.

          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Text(
              'Wähle den Modus:',
            ),
            Text(
              'Wähle die Farben:',
            ),
            ColorSelector(setColor, 0),
            ColorSelector(setColor, 1),
            ColorSelector(setColor, 2)
          ],
        ),
      ),
    );
  }
}
