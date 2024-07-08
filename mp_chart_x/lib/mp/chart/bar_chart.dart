import 'package:flutter/cupertino.dart';
import 'package:mp_chart_x/mp/chart/bar_line_scatter_candle_bubble_chart.dart';
import 'package:mp_chart_x/mp/controller/bar_chart_controller.dart';

class BarChart extends BarLineScatterCandleBubbleChart<BarChartController> {
  const BarChart(BarChartController controller, {Key? key}) : super(controller, key: key);
}

class BarChartState extends BarLineScatterCandleBubbleState<BarChart> {}
