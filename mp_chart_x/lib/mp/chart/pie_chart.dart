import 'package:flutter/cupertino.dart';
import 'package:mp_chart_x/mp/chart/pie_radar_chart.dart';
import 'package:mp_chart_x/mp/controller/pie_chart_controller.dart';

class PieChart extends PieRadarChart<PieChartController> {
  const PieChart(PieChartController controller, {Key? key}) : super(controller, key: key);
}

class PieChartState extends PieRadarChartState<PieChart> {}
