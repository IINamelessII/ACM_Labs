import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 1 Serikov',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Lab 1 Serikov'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController a1 = new TextEditingController();
  TextEditingController b1 = new TextEditingController();
  TextEditingController r2 = new TextEditingController();
  TextEditingController g2 = new TextEditingController();
  TextEditingController x2 = new TextEditingController();
  TextEditingController a3 = new TextEditingController();
  TextEditingController b3 = new TextEditingController();
  TextEditingController n3 = new TextEditingController();
  String _res1 = '';
  String _res2 = '';
  String _res3 = '';

  void _calc1() {
    setState(() {
      double _a = double.parse(a1.text);
      double _b = double.parse(b1.text);
      if (_a + _b != 0) {
        double _d = sin((_a + _b) / pow((_a + _b), 2));
        _res1 = 'Result is ' + _d.toString();
      } else {
        _res1 = "Please type correct data";
      }
    });
  }

  void _calc2() {
    setState(() {
      double _r = double.parse(r2.text);
      double _g = double.parse(g2.text);
      double _x = double.parse(x2.text);
      if (_r * _g != 0) {
        double _d = (_x + 24 + pow(_x, 2)) / (_r * _g);
        _res2 = 'Result is ' + _d.toString();
      } else {
        double _d = pow((_r + _x), 0.5) + _g * _x;
        _res2 = 'Result is ' + _d.toString();
      }
    });
  }

  void _calc3() {
    setState(() {
      double _a = double.parse(a3.text);
      double _b = double.parse(b3.text);
      double _n = double.parse(n3.text);
      if (_a + _b != 0 && _n != 0) {
        int fact = 1;
        for (int i = 1; i <= _n; ++i) {
          fact *= i;
        }
        double _d = fact / (_n * (_a + _b));
        _res3 = 'Result is ' + _d.toString();
      } else {
        _res3 = "Please type correct data";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: <Widget>[
            Center(child: Text('Task 1')),
            Image.asset('assets/images/task1.png'),
            TextField(
              decoration: new InputDecoration(labelText: "Enter a"),
              keyboardType: TextInputType.number,
              controller: a1,
            ),
            TextField(
              decoration: new InputDecoration(labelText: "Enter b"),
              keyboardType: TextInputType.number,
              controller: b1,
            ),
            RaisedButton(
              onPressed: _calc1,
              child: Text('Calc 1st'),
            ),
            Text(_res1),
            //Separator
            Center(child: Text('Task 2')),
            Image.asset('assets/images/task2.png'),
            TextField(
              decoration: new InputDecoration(labelText: "Enter r"),
              keyboardType: TextInputType.number,
              controller: r2,
            ),
            TextField(
              decoration: new InputDecoration(labelText: "Enter q"),
              keyboardType: TextInputType.number,
              controller: g2,
            ),
            TextField(
              decoration: new InputDecoration(labelText: "Enter x"),
              keyboardType: TextInputType.number,
              controller: x2,
            ),
            RaisedButton(
              onPressed: _calc2,
              child: Text('Calc 2nd'),
            ),
            Text(_res2),
            //Separator
            Center(child: Text('Task 3')),
            Image.asset('assets/images/task3.png'),
            TextField(
              decoration: new InputDecoration(labelText: "Enter a"),
              keyboardType: TextInputType.number,
              controller: a3,
            ),
            TextField(
              decoration: new InputDecoration(labelText: "Enter b"),
              keyboardType: TextInputType.number,
              controller: b3,
            ),
            TextField(
              decoration: new InputDecoration(labelText: "Enter n"),
              keyboardType: TextInputType.number,
              controller: n3,
            ),
            RaisedButton(
              onPressed: _calc3,
              child: Text('Calc 3rd'),
            ),
            Text(_res3),
          ],
        ));
  }
}
