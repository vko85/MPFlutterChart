import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mp_chart_x/mp/chart/horizontal_bar_chart.dart';
import 'package:mp_chart_x/mp/controller/horizontal_bar_chart_controller.dart';
import 'package:mp_chart_x/mp/core/common_interfaces.dart';
import 'package:mp_chart_x/mp/core/data/bar_data.dart';
import 'package:mp_chart_x/mp/core/data_set/bar_data_set.dart';
import 'package:mp_chart_x/mp/core/description.dart';
import 'package:mp_chart_x/mp/core/entry/bar_entry.dart';
import 'package:mp_chart_x/mp/core/entry/entry.dart';
import 'package:mp_chart_x/mp/core/enums/axis_dependency.dart';
import 'package:mp_chart_x/mp/core/enums/legend_horizontal_alignment.dart';
import 'package:mp_chart_x/mp/core/enums/legend_orientation.dart';
import 'package:mp_chart_x/mp/core/enums/legend_vertical_alignment.dart';
import 'package:mp_chart_x/mp/core/enums/x_axis_position.dart';
import 'package:mp_chart_x/mp/core/highlight/highlight.dart';
import 'package:mp_chart_x/mp/core/image_loader.dart';
import 'package:mp_chart_x/mp/core/value_formatter/value_formatter.dart';
import 'package:example/demo/action_state.dart';

class BarChartStacked2 extends StatefulWidget {
  const BarChartStacked2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BarChartStacked2State();
  }
}

class BarChartStacked2State extends HorizontalBarActionState<BarChartStacked2>
    implements OnChartValueSelectedListener {
  @override
  void initState() {
    _initController();
    _initBarData();
    super.initState();
  }

  @override
  String getTitle() => "Bar Chart Stacked2";

  @override
  Widget getBody() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          bottom: 0,
          child: HorizontalBarChart(controller),
        ),
      ],
    );
  }

  void _initBarData() async {
    var img = await ImageLoader.loadImage('assets/img/star.png');
    // IMPORTANT: When using negative values in stacked bars, always make sure the negative values are in the array first
    List<BarEntry> values = [];
    values.add(BarEntry.fromListYVals(
        x: 5,
        vals: [-10, 10],
        icon: img));
    values.add(BarEntry.fromListYVals(
        x: 15,
        vals: [-12, 13],
        icon: img));
    values.add(BarEntry.fromListYVals(
        x: 25,
        vals: [-15, 15],
        icon: img));
    values.add(BarEntry.fromListYVals(
        x: 35,
        vals: [-17, 17],
        icon: img));
    values.add(BarEntry.fromListYVals(
        x: 45,
        vals: [-19, 20],
        icon: img));
    values.add(BarEntry.fromListYVals(
        x: 45,
        vals: [-19, 20],
        icon: img
//        getResources().getDrawable(R.drawable.star)
        ));
    values.add(BarEntry.fromListYVals(
        x: 55,
        vals: [-19, 19],
        icon: img));
    values.add(BarEntry.fromListYVals(
        x: 65,
        vals: [-16, 16],
        icon: img));
    values.add(BarEntry.fromListYVals(
        x: 75,
        vals: [-13, 14],
        icon: img));
    values.add(BarEntry.fromListYVals(
        x: 85,
        vals: [-10, 11],
        icon: img));
    values.add(BarEntry.fromListYVals(
        x: 95,
        vals: [-5, 6],
        icon: img));
    values.add(BarEntry.fromListYVals(
        x: 105,
        vals: [-1, 2],
        icon: img));

    BarDataSet set = BarDataSet(values, "Age Distribution");
    set.setDrawIcons(false);
    set.setValueFormatter(B());
    set.setValueTextSize(7);
    set.setAxisDependency(AxisDependency.right);
    set.setColors1([Color.fromARGB(255, 67, 67, 72), Color.fromARGB(255, 124, 181, 236)]);
    set.setStackLabels(["Men", "Women"]);

    controller.data = BarData([set]);
    controller.data?.barWidth = (8.5);

    setState(() {});
  }

  void _initController() {
    var desc = Description()..enabled = false;
    controller = HorizontalBarChartController(
        axisLeftSettingFunction: (axisLeft, controller) {
          axisLeft.enabled = (false);
        },
        axisRightSettingFunction: (axisRight, controller) {
          axisRight
            ..setAxisMaximum(25)
            ..setAxisMinimum(-25)
            ..drawGridLines = (false)
            ..setDrawZeroLine(true)
            ..setLabelCount2(7, false)
            ..setValueFormatter(A())
            ..textSize = (9);
        },
        legendSettingFunction: (legend, controller) {
          legend
            ..verticalAlignment = (LegendVerticalAlignment.bottom)
            ..horizontalAlignment = (LegendHorizontalAlignment.right)
            ..orientation = (LegendOrientation.horizontal)
            ..drawInside = (false)
            ..formSize = (8)
            ..formToTextSpace = (4)
            ..xEntrySpace = (6);
        },
        xAxisSettingFunction: (xAxis, controller) {
          xAxis
            ..position = (XAxisPosition.bothSided)
            ..drawGridLines = (false)
            ..drawAxisLine = (false)
            ..textSize = (9)
            ..setAxisMinimum(0)
            ..setAxisMaximum(110)
            ..centerAxisLabels = (true)
            ..setLabelCount1(12)
            ..setGranularity(10)
            ..setValueFormatter(B());
        },
        drawGridBackground: false,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        pinchZoomEnabled: false,
        selectionListener: this,
        drawBarShadow: false,
        drawValueAboveBar: true,
        highlightFullBarEnabled: false,
        description: desc);
  }

  @override
  void onNothingSelected() {}

  @override
  void onValueSelected(Entry? e, Highlight? h) {}
}

class A extends ValueFormatter {
  NumberFormat mFormat= NumberFormat("###");

  A() {
    mFormat = NumberFormat("###");
  }

  @override
  String getFormattedValue1(double value) {
    return "${mFormat.format(value.abs())}m";
  }
}

class B extends ValueFormatter {
  NumberFormat mFormat = NumberFormat("###");

  B() {
    mFormat = NumberFormat("###");
  }

  @override
  String getFormattedValue1(double value) {
    return "${mFormat.format(value)}-${mFormat.format(value + 10)}";
  }
}
