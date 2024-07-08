import 'package:flutter/cupertino.dart';
import 'package:mp_chart_x/mp/chart/bar_line_scatter_candle_bubble_chart.dart';
import 'package:mp_chart_x/mp/controller/candlestick_chart_controller.dart';

class CandlestickChart
    extends BarLineScatterCandleBubbleChart<CandlestickChartController> {
  const CandlestickChart(CandlestickChartController controller, {Key? key})
      : super(controller, key: key);
}

class CandlestickChartState
    extends BarLineScatterCandleBubbleState<CandlestickChart> {}
