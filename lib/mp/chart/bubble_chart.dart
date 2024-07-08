import 'package:flutter/cupertino.dart';
import 'package:mp_chart_x/mp/chart/bar_line_scatter_candle_bubble_chart.dart';
import 'package:mp_chart_x/mp/controller/bubble_chart_controller.dart';

class BubbleChart
    extends BarLineScatterCandleBubbleChart<BubbleChartController> {
  const BubbleChart(BubbleChartController controller, {Key? key}) : super(controller, key: key);
}

class BubbleChartState extends BarLineScatterCandleBubbleState<BubbleChart> {}
