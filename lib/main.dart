import 'dart:convert';
import 'package:awesome_flutter_app/MyChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Inr {
  int index;
  int value;
  List<String> tags;

  Inr(this.index, this.value, this.tags);
}

class _MyHomePageState extends State<MyHomePage> {
  List<DataRow> rows = [];
  List<Inr> inrs = [];

  void addRowToList(List<DataRow> newRows, List<Inr> newInrs) {
    setState(() {
      rows = newRows;
      inrs = newInrs;
    });
  }

  Future<List<Inr>> loadJson() async {
    String data = await rootBundle.loadString('./lib/assets/inrs.json');
    final List<dynamic> jsonResult = json.decode(data);
    List<Inr> inrs = (jsonResult.map((inr) => Inr(inr["index"], inr["value"],
        (inr["tags"] as List).map((tag) => tag as String).toList()))).toList();
    return inrs;
  }

  createInrsRows() async {
    List<Inr> inrs = await loadJson();
    addRowToList(
        inrs
            .map((Inr inr) => DataRow(cells: <DataCell>[
                  DataCell(Text(inr.value.toString())),
                  DataCell(Text(inr.tags.join(", ")))
                ]))
            .toList(),
        inrs);
  }

  @override
  void initState() {
    createInrsRows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Mesure',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Tags',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: rows,
            ),
            MyChart([])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createInrsRows,
        tooltip: 'Upload INRS',
        child: Icon(Icons.cloud_upload),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
