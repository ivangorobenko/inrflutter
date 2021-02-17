import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'main.dart';

class InrChart extends StatelessWidget {
  final List<charts.Series<Inr, int>> seriesList;
  final bool animate;

  InrChart(this.seriesList, {this.animate});

  factory InrChart.withData(inrs) {
    return new InrChart(
      [
        new charts.Series<Inr, int>(
          id: 'Inr',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (Inr inr, _) => inr.index,
          measureFn: (Inr inr, _) => inr.value,
          data: inrs,
        )
      ],
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate);
  }
}