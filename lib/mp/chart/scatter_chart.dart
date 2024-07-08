import 'package:flutter/cupertino.dart';
import 'package:mp_chart_x/mp/chart/bar_line_scatter_candle_bubble_chart.dart';
import 'package:mp_chart_x/mp/controller/scatter_chart_controller.dart';

class ScatterChart
    extends BarLineScatterCandleBubbleChart<ScatterChartController> {
  const ScatterChart(ScatterChartController controller, {Key? key}) : super(controller, key: key);
}

class ScatterChartState extends BarLineScatterCandleBubbleState<ScatterChart> {}
