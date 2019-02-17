import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 2 Serikov',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Lab 2 Serikov'),
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
  bool wasGenerated = false;
  bool wasSorted = false;
  static final lengths = new List<int>.generate(10, (i) => i * 2 + 10);
  static final size = 10;
  var grid;
  String gridStr = '';
  String sortedGridStr = '';
  String timesStr = '';
  List<int> times = new List(size);

  void generate() {
    setState(() {
      grid = List<List<int>>.generate(size,
          (i) => List<int>.generate(lengths[i], (j) => Random().nextInt(9)));
      wasGenerated = true;
      wasSorted = false;
      gridStr = grid.toString().replaceAll('], [', ']\n[');
      gridStr = gridStr.substring(1, gridStr.length - 1);
      sortedGridStr = '';
    });
  }

  void sort() {
    setState(() {
      grid = List<List<int>>.generate(size, (i) => sortHoare(grid[i], i));
      sortedGridStr = grid.toString().replaceAll('], [', ']\n[');
      sortedGridStr = sortedGridStr.substring(1, sortedGridStr.length - 1);
      wasSorted = true;
      timesStr = times.toString().replaceAll(', ', 'μs\nTime is: ');
      timesStr = 'Time is: ' + timesStr.substring(1, timesStr.length - 1) + 'μs';
    });
  }

  List<int> sortHoare(List<int> list, int index) {
    Stopwatch _watch = new Stopwatch()..start();
    hoareSort(list, 0, list.length - 1);
    times[index] = _watch.elapsedMicroseconds;
//    print(index);
//    times[index] = 3;
    return list;
  }

  void hoareSort(List<int> array, int left, int right) {
    int base, opposite, p, c;
    base = left;
    opposite = right;
    while (base != opposite) {
      if ((array[base] > array[opposite]) ^ (base > opposite)) {
        c = array[base];
        array[base] = array[opposite];
        array[opposite] = c;
        p = base;
        base = opposite;
        if (p < opposite) {
          opposite = p + 1;
        } else {
          opposite = p - 1;
        }
      } else {
        if (base < opposite) {
          opposite--;
        } else {
          opposite++;
        }
      }
    }
    if (left < base - 1) hoareSort(array, left, base - 1);
    if (base + 1 < right) hoareSort(array, base + 1, right);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: <Widget>[
            Center(child: Text('Arrays:')),
            RaisedButton(
              onPressed: generate,
              child: Text('Generate'),
            ),
            Text(gridStr),
            (wasGenerated && !wasSorted
                ? RaisedButton(onPressed: sort, child: Text('Sort'))
                : Text('')),
            Text(sortedGridStr + '\n'),
            (wasSorted && wasGenerated ? Text(timesStr) : Text('')),
          ],
        ));
  }
}
