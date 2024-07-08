import 'package:flutter/cupertino.dart';
import 'package:mp_chart_x/mp/chart/bar_line_scatter_candle_bubble_chart.dart';
import 'package:mp_chart_x/mp/controller/line_chart_controller.dart';

class LineChart extends BarLineScatterCandleBubbleChart<LineChartController> {
  const LineChart(LineChartController controller, {Key? key}) : super(controller, key: key);
}

class LineChartState extends BarLineScatterCandleBubbleState<LineChart> {}
