import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'main.dart';

class MyChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  MyChart(this.seriesList, {this.animate});

  factory MyChart.withSampleData() {
    return new MyChart(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Inr, int>> _createSampleData() {
    final inrs = [Inr(1, 21, ["daze"])];
    return [
      new charts.Series<Inr, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Inr inr, _) => inr.index,
        measureFn: (Inr inr, _) => inr.value,
        data: inrs,
      )
    ];
  }
}
