import 'dart:async';
import 'dart:math';

import 'package:example/demo/action_state.dart';
import 'package:example/demo/util.dart';
import 'package:flutter/material.dart';
import 'package:mp_chart_x/mp/chart/line_chart.dart';
import 'package:mp_chart_x/mp/controller/line_chart_controller.dart';
import 'package:mp_chart_x/mp/core/common_interfaces.dart';
import 'package:mp_chart_x/mp/core/data/line_data.dart';
import 'package:mp_chart_x/mp/core/data_interfaces/i_line_data_set.dart';
import 'package:mp_chart_x/mp/core/data_set/line_data_set.dart';
import 'package:mp_chart_x/mp/core/description.dart';
import 'package:mp_chart_x/mp/core/entry/entry.dart';
import 'package:mp_chart_x/mp/core/enums/axis_dependency.dart';
import 'package:mp_chart_x/mp/core/enums/legend_form.dart';
import 'package:mp_chart_x/mp/core/highlight/highlight.dart';
import 'package:mp_chart_x/mp/core/utils/color_utils.dart';

class EvenMoreRealtime extends StatefulWidget {
  const EvenMoreRealtime({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EvenMoreRealtimeState();
  }
}

class EvenMoreRealtimeState extends ActionState<EvenMoreRealtime>
    implements OnChartValueSelectedListener {
  late LineChartController controller;
  var random = Random(1);
  var isMultipleRun = false;

  @override
  void initState() {
    _initController();
    super.initState();
  }

  @override
  Widget getBody() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          bottom: 0,
          child: LineChart(controller),
        ),
      ],
    );
  }

  @override
  getBuilder() {
    return (BuildContext context) => <PopupMenuItem<String>>[
          item('View on GitHub', 'A'),
          item('Add Entry', 'B'),
          item('Clear Chart', 'C'),
          item('Add Multiple', 'D'),
          item('Save to Gallery', 'E'),
          item('Update Random Single Entry', 'F'),
        ];
  }

  @override
  String getTitle() {
    return "Even More Realtime";
  }

  @override
  void itemClick(String action) {
    if (controller.state == null) {
      return;
    }

    switch (action) {
      case 'A':
        Util.openGithub();
        break;
      case 'B':
        _addEntry();
        controller.state.setStateIfNotDispose();
        break;
      case 'C':
        _clearChart();
        controller.state.setStateIfNotDispose();
        break;
      case 'D':
        _addMultiple();
        controller.state.setStateIfNotDispose();
        break;
      case 'E':
        // captureImg(() {
        //   controller.state.capture();
        // });
        break;
      case 'F':
        _updateEntry();
        break;
    }
  }

  void _initController() {
    var desc = Description()..enabled = false;
    controller = LineChartController(
        legendSettingFunction: (legend, controller) {
          legend
            ..shape = LegendForm.line
            ..typeface = Util.LIGHT
            ..textColor = ColorUtils.white;
        },
        xAxisSettingFunction: (xAxis, controller) {
          xAxis
            ..typeface = Util.LIGHT
            ..textColor = ColorUtils.white
            ..drawGridLines = true
            ..avoidFirstLastClipping = true
            ..enabled = true;
        },
        axisLeftSettingFunction: (axisLeft, controller) {
          axisLeft
            ..typeface = Util.LIGHT
            ..textColor = ColorUtils.white
            ..axisMaximum = 100.0
            ..axisMinimum = 0.0
            ..drawGridLines = true;
        },
        axisRightSettingFunction: (axisRight, controller) {
          axisRight.enabled = false;
        },
        drawGridBackground: false,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        backgroundColor: ColorUtils.ltGray,
        selectionListener: this,
        pinchZoomEnabled: true,
        description: desc);

    LineData? data = controller.data;

    if (data == null) {
      data = LineData();
      controller.data = data;
    }
  }

  @override
  void onNothingSelected() {}

  @override
  void onValueSelected(Entry? e, Highlight? h) {}

  void _addEntry() {
    LineData? data = controller.data;

    if (data != null) {
      ILineDataSet? set = data.getDataSetByIndex(0);
      // set.addEntry(...); // can be called as well

      if (set == null) {
        set = _createSet();
        data.addDataSet(set);
      }

      data.addEntry(
          Entry(
              x: set.getEntryCount().toDouble(),
              y: (random.nextDouble() * 40) + 30.0),
          0);
      data.notifyDataChanged();

      // limit the number of visible entries
      controller.setVisibleXRangeMaximum(120);
      // chart.setVisibleYRange(30, AxisDependency.LEFT);

      // move to the latest entry
      controller.moveViewToX(data.getEntryCount().toDouble());

      controller.state.setStateIfNotDispose();
    }
  }

  void _updateEntry() {
    LineData? data = controller.data;

    if (data != null) {
      ILineDataSet? set = data.getDataSetByIndex(0);
      // set.addEntry(...); // can be called as well

      if (set == null) {
        set = _createSet();
        data.addDataSet(set);
      }

      if (set.getEntryCount() == 0) {
        return;
      }

      //for test ChartData's updateEntryByIndex
      var index = (random.nextDouble() * set.getEntryCount()).toInt();
      var x = set.getEntryForIndex(index)?.x??0;
      data.updateEntryByIndex(
          index, Entry(x: x, y: (random.nextDouble() * 40) + 30.0), 0);

      data.notifyDataChanged();

      // limit the number of visible entries
      controller.setVisibleXRangeMaximum(120);
      // chart.setVisibleYRange(30, AxisDependency.LEFT);

      // move to the latest entry
      controller.moveViewToX(data.getEntryCount().toDouble());

      controller.state.setStateIfNotDispose();
    }
  }

  void _clearChart() {
    controller.data?.clearValues();
    controller.state.setStateIfNotDispose();
  }

  void _addMultiple() {
    if (isMultipleRun) {
      return;
    }

    isMultipleRun = true;
    var i = 0;
    Timer.periodic(Duration(milliseconds: 25), (timer) {
      _addEntry();
      if (i++ > 1000) {
        timer.cancel();
        isMultipleRun = false;
      }
    });
  }

  LineDataSet _createSet() {
    LineDataSet set = LineDataSet([], "Dynamic Data");
    set.setAxisDependency(AxisDependency.left);
    set.setColor1(ColorUtils.getHoloBlue());
    set.setCircleColor(ColorUtils.white);
    set.setLineWidth(2.0);
    set.setCircleRadius(4.0);
    set.setFillAlpha(65);
    set.setFillColor(ColorUtils.getHoloBlue());
    set.setHighLightColor(Color.fromARGB(255, 244, 117, 117));
    set.setValueTextColor(ColorUtils.white);
    set.setValueTextSize(9.0);
    set.setDrawValues(false);
    return set;
  }
}
