import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mp_chart_x/mp/chart/line_chart.dart';
import 'package:mp_chart_x/mp/controller/line_chart_controller.dart';
import 'package:mp_chart_x/mp/core/data/line_data.dart';
import 'package:mp_chart_x/mp/core/data_interfaces/i_line_data_set.dart';
import 'package:mp_chart_x/mp/core/data_provider/line_data_provider.dart';
import 'package:mp_chart_x/mp/core/data_set/line_data_set.dart';
import 'package:mp_chart_x/mp/core/description.dart';
import 'package:mp_chart_x/mp/core/entry/entry.dart';
import 'package:mp_chart_x/mp/core/enums/axis_dependency.dart';
import 'package:mp_chart_x/mp/core/fill_formatter/i_fill_formatter.dart';
import 'package:mp_chart_x/mp/core/utils/color_utils.dart';
import 'package:example/demo/action_state.dart';

class LineChartFilled extends StatefulWidget {
  const LineChartFilled({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LineChartFilledState();
  }
}

class LineChartFilledState extends SimpleActionState<LineChartFilled> {
  late LineChartController _controller;
  var random = Random(1);
  int _count = 45;
  double _range = 100.0;

  @override
  void initState() {
    _initController();
    _initLineData(_count, _range);
    super.initState();
  }

  @override
  String getTitle() => "Line Chart Filled";

  @override
  Widget getBody() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          bottom: 100,
          child: LineChart(_controller),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Center(
                        child: Slider(
                            value: _count.toDouble(),
                            min: 0,
                            max: 700,
                            onChanged: (value) {
                              _count = value.toInt();
                              _initLineData(_count, _range);
                            })),
                  ),
                  Container(
                      constraints: BoxConstraints.expand(height: 50, width: 60),
                      padding: EdgeInsets.only(right: 15.0),
                      child: Center(
                          child: Text(
                        "$_count",
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorUtils.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ))),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Center(
                        child: Slider(
                            value: _range,
                            min: 1,
                            max: 150,
                            onChanged: (value) {
                              _range = value;
                              _initLineData(_count, _range);
                            })),
                  ),
                  Container(
                      constraints: BoxConstraints.expand(height: 50, width: 60),
                      padding: EdgeInsets.only(right: 15.0),
                      child: Center(
                          child: Text(
                        "${_range.toInt()}",
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorUtils.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ))),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  void _initController() {
    var desc = Description()..enabled = false;
    _controller = LineChartController(
        axisLeftSettingFunction: (axisLeft, controller) {
          axisLeft
            ..setAxisMaximum(900)
            ..setAxisMinimum(-250)
            ..drawAxisLine = (false)
            ..setDrawZeroLine(false)
            ..drawGridLines = (false);
        },
        axisRightSettingFunction: (axisRight, controller) {
          axisRight.enabled = (false);
        },
        legendSettingFunction: (legend, controller) {
          legend.enabled = (false);
          var formatter1 = (controller as LineChartController)
              .data
              ?.getDataSetByIndex(0)
              ?.getFillFormatter();
          if (formatter1 is A) {
            formatter1.setPainter(controller);
          }
          var formatter2 = (controller)
              .data
              ?.getDataSetByIndex(1)
              ?.getFillFormatter();
          if (formatter2 is B) {
            formatter2.setPainter(controller);
          }
        },
        xAxisSettingFunction: (xAxis, controller) {
          xAxis.enabled = (false);
        },
        drawBorders: true,
        drawGridBackground: true,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        pinchZoomEnabled: false,
        gridBackColor: _fillColor,
        backgroundColor: ColorUtils.white,
        description: desc);
  }

  void _initLineData(int count, double range) {
    List<Entry> values1 = [];

    for (int i = 0; i < count; i++) {
      double val = (random.nextDouble() * range) + 50;
      values1.add(Entry(x: i.toDouble(), y: val));
    }

    List<Entry> values2 = [];

    for (int i = 0; i < count; i++) {
      double val = (random.nextDouble() * range) + 450;
      values2.add(Entry(x: i.toDouble(), y: val));
    }

    LineDataSet set1, set2;

    // create a dataset and give it a type
    set1 = LineDataSet(values1, "DataSet 1");

    set1.setAxisDependency(AxisDependency.left);
    set1.setColor1(Color.fromARGB(255, 255, 241, 46));
    set1.setDrawCircles(false);
    set1.setLineWidth(2);
    set1.setCircleRadius(3);
    set1.setFillAlpha(255);
    set1.setDrawFilled(true);
    set1.setFillColor(ColorUtils.white);
    set1.setHighLightColor(Color.fromARGB(255, 244, 117, 117));
    set1.setDrawCircleHole(false);
    set1.setFillFormatter(A());

    // create a dataset and give it a type
    set2 = LineDataSet(values2, "DataSet 2");
    set2.setAxisDependency(AxisDependency.left);
    set2.setColor1(Color.fromARGB(255, 255, 241, 46));
    set2.setDrawCircles(false);
    set2.setLineWidth(2);
    set2.setCircleRadius(3);
    set2.setFillAlpha(255);
    set2.setDrawFilled(true);
    set2.setFillColor(ColorUtils.white);
    set2.setDrawCircleHole(false);
    set2.setHighLightColor(Color.fromARGB(255, 244, 117, 117));
    set2.setFillFormatter(B());

    // create a data object with the data sets
    _controller.data = LineData.fromList([set1, set2]);
    _controller.data?.setDrawValues(false);

    setState(() {});
  }

  final Color _fillColor = Color.fromARGB(150, 51, 181, 229);
}

class A implements IFillFormatter {
  late LineChartController _controller;

  void setPainter(LineChartController controller) {
    _controller = controller;
  }

  @override
  double getFillLinePosition(
      ILineDataSet dataSet, LineDataProvider? dataProvider) {
    return _controller.painter?.axisLeft?.axisMinimum ?? 0;
  }
}

class B implements IFillFormatter {
  late LineChartController _controller;

  void setPainter(LineChartController controller) {
    _controller = controller;
  }

  @override
  double getFillLinePosition(
      ILineDataSet dataSet, LineDataProvider? dataProvider) {
    return _controller.painter?.axisLeft?.axisMaximum ?? 0;
  }
}
