import 'package:flutter/cupertino.dart';
import 'package:mp_chart_x/mp/chart/pie_radar_chart.dart';
import 'package:mp_chart_x/mp/controller/radar_chart_controller.dart';

class RadarChart extends PieRadarChart<RadarChartController> {
  const RadarChart(RadarChartController controller, {Key? key}) : super(controller, key: key);
}

class RadarChartState extends PieRadarChartState<RadarChart> {}
