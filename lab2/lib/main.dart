import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторна 2 Серіков',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Лабораторна 2 Серіков'),
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
  bool displayArrays = false;
  bool displaySortedArrays = false;
  TextEditingController lenController = new TextEditingController();
  TextEditingController maxController = new TextEditingController();
  static final size = 10;
  var grid;
  String gridStr = '';
  String sortedGridStr = '';
  String timesStr = '';
  List<int> times = new List(size);

  void generate() {
    setState(() {
      int len = lenController.text.length > 0 ? int.parse(lenController.text) : 1000;
      int max = maxController.text.length > 0 ? int.parse(maxController.text) : 9;
      var lengths = new List<int>.generate(10, (i) => (i + 1) * len);
      grid = List<List<int>>.generate(size,
          (i) => List<int>.generate(lengths[i], (j) => Random().nextInt(max + 1)));
      wasGenerated = true;
      wasSorted = false;
      gridStr = grid.toString().replaceAll('], [', ']\n\n[');
      gridStr = gridStr.substring(1, gridStr.length - 1);
      sortedGridStr = '';
    });
  }

  void sort() {
    setState(() {
      grid = List<List<int>>.generate(size, (i) => sortHoare(grid[i], i));
      sortedGridStr = grid.toString().replaceAll('], [', ']\n\n[');
      sortedGridStr = sortedGridStr.substring(1, sortedGridStr.length - 1);
      wasSorted = true;
      timesStr = times.toString().replaceAll(', ', '*10^-6с\nЧас: ');
      timesStr = 'Час: ' + timesStr.substring(1, timesStr.length - 1) + '*10^-6с';
    });
  }

  void showArrays() {
    setState(() {
      displayArrays = !displayArrays;
    });
  }

  void showSortedArrays() {
    setState(() {
      displaySortedArrays = !displaySortedArrays;
    });
  }

  List<int> sortHoare(List<int> list, int index) {
    Stopwatch _watch = new Stopwatch()..start();
    hoareSort(list, 0, list.length - 1);
    times[index] = _watch.elapsedMicroseconds;
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
            Text(
              "За замовчуванням кратність 1000, а max елемент 9"
            ),
            TextField(
              decoration: new InputDecoration(labelText: "Введіть кратність довжин масивів"),
              keyboardType: TextInputType.number,
              controller: lenController,
            ),
            TextField(
              decoration: new InputDecoration(labelText: "Введіть max значення елементів масиву"),
              keyboardType: TextInputType.number,
              controller: maxController,
            ),
            RaisedButton(
              onPressed: generate,
              child: Text('Зенерувати масиви'),
            ),
            (wasGenerated ? RaisedButton(
              onPressed: showArrays,
              child: Text(!displayArrays ? 'Показати масиви повністю' : 'Сховати массиви'),
            ): Text('')),
            (wasGenerated ? SingleChildScrollView(child:
            Text(displayArrays ? gridStr : ''),
            ) : Text('')),
            (wasGenerated && !wasSorted
                ? RaisedButton(
                    onPressed: sort, child: Text('Відсортувати масиви'))
                : Text('')),
            (wasSorted && wasGenerated ? Text(timesStr) : Text('')),
            (wasGenerated && wasSorted ? RaisedButton(
              onPressed: showSortedArrays,
              child: Text(!displaySortedArrays ? 'Показати відсортовані масиви повністю' : 'Сховати відсортовані массиви'),
            ) : Text('')),
            (wasGenerated && wasGenerated ? SingleChildScrollView(child:
            Text(displaySortedArrays ? sortedGridStr : ''),
            ) : Text('')),
          ],
        ));
  }
}
