import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mp_chart_x/mp/chart/line_chart.dart';
import 'package:mp_chart_x/mp/controller/line_chart_controller.dart';
import 'package:mp_chart_x/mp/core/data/line_data.dart';
import 'package:mp_chart_x/mp/core/data_set/line_data_set.dart';
import 'package:mp_chart_x/mp/core/description.dart';
import 'package:mp_chart_x/mp/core/entry/entry.dart';
import 'package:mp_chart_x/mp/core/utils/color_utils.dart';
import 'package:example/demo/action_state.dart';
import 'package:example/demo/util.dart';

class LineChartColorful extends StatefulWidget {
  const LineChartColorful({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LineChartColorfulState();
  }
}

class LineChartColorfulState extends SimpleActionState<LineChartColorful> {
  final List<LineChartController> _controllers = [];
  var random = Random(1);
  final int _count = 36;
  final double _range = 100.0;

  final List<Color> _colors = [
    Color.fromARGB(255, 137, 230, 81),
    Color.fromARGB(255, 240, 240, 30),
    Color.fromARGB(255, 89, 199, 250),
    Color.fromARGB(255, 250, 104, 104)
  ];

  @override
  void initState() {
    _initController();
    _initLineData(_count, _range);
    super.initState();
  }

  @override
  String getTitle() => "Line Chart Colorful";

  @override
  Widget getBody() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: getLineChart(_controllers[0]),
              ),
              Expanded(
                flex: 1,
                child: getLineChart(_controllers[1]),
              ),
              Expanded(
                flex: 1,
                child: getLineChart(_controllers[2]),
              ),
              Expanded(
                flex: 1,
                child: getLineChart(_controllers[3]),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _initController() {
    for (int i = 0; i < 4; i++) {
      _controllers.add(_setupChartController(_colors[i % _colors.length]));
    }
  }

  void _initLineData(int count, double range) {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].data = _getData(36, 100);
      _controllers[i].data?.setValueTypeface(Util.BOLD);
      (_controllers[i].data?.getDataSetByIndex(0) as LineDataSet)
          .setCircleHoleColor(_colors[i % _colors.length]);
    }
  }

  LineData _getData(int count, double range) {
    List<Entry> values = [];

    for (int i = 0; i < count; i++) {
      double val = (random.nextDouble() * range) + 3;
      values.add(Entry(x: i.toDouble(), y: val));
    }

    // create a dataset and give it a type
    LineDataSet set1 = LineDataSet(values, "DataSet 1");
    set1.setFillAlpha(110);
    set1.setFillColor(ColorUtils.red);

    set1.setLineWidth(1.75);
    set1.setCircleRadius(5);
    set1.setCircleHoleRadius(2.5);
    set1.setColor1(ColorUtils.white);
    set1.setCircleColor(ColorUtils.white);
    set1.setHighLightColor(ColorUtils.white);
    set1.setDrawValues(false);

    // create a data object with the data sets
    return LineData.fromList([set1]);
  }

  LineChartController _setupChartController(Color color) {
    var desc = Description()..enabled = false;
    return LineChartController(
        axisLeftSettingFunction: (axisLeft, controller) {
          axisLeft
            ..enabled = (false)
            ..spacePercentTop = (40)
            ..spacePercentBottom = (40);
        },
        axisRightSettingFunction: (axisRight, controller) {
          axisRight.enabled = (false);
        },
        legendSettingFunction: (legend, controller) {
          legend.enabled = (false);
          (controller as LineChartController).setViewPortOffsets(0, 0, 0, 0);
        },
        xAxisSettingFunction: (xAxis, controller) {
          xAxis.enabled = (false);
        },
        drawGridBackground: true,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        pinchZoomEnabled: false,
        gridBackColor: color,
        backgroundColor: color,
        description: desc);
  }

  Widget getLineChart(LineChartController controller) {
    var lineChart = LineChart(controller);
    controller.animator
      ?..reset()
      ..animateX1(2500);
    return lineChart;
  }
}
