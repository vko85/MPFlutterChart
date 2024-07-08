import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mp_chart_x/mp/chart/pie_chart.dart';
import 'package:mp_chart_x/mp/controller/pie_chart_controller.dart';
import 'package:mp_chart_x/mp/core/animator.dart';
import 'package:mp_chart_x/mp/core/data/pie_data.dart';
import 'package:mp_chart_x/mp/core/data_set/pie_data_set.dart';
import 'package:mp_chart_x/mp/core/description.dart';
import 'package:mp_chart_x/mp/core/entry/pie_entry.dart';
import 'package:mp_chart_x/mp/core/enums/legend_horizontal_alignment.dart';
import 'package:mp_chart_x/mp/core/enums/legend_orientation.dart';
import 'package:mp_chart_x/mp/core/enums/legend_vertical_alignment.dart';
import 'package:mp_chart_x/mp/core/image_loader.dart';
import 'package:mp_chart_x/mp/core/render/pie_chart_renderer.dart';
import 'package:mp_chart_x/mp/core/utils/color_utils.dart';
import 'package:mp_chart_x/mp/core/value_formatter/percent_formatter.dart';
import 'package:example/demo/action_state.dart';
import 'package:example/demo/util.dart';

class PieChartHalfPie extends StatefulWidget {
  const PieChartHalfPie({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PieChartHalfPieState();
  }
}

class PieChartHalfPieState extends SimpleActionState<PieChartHalfPie> {
  late PieChartController _controller;
  var random = Random(1);

  @override
  void initState() {
    _initController();
    _initPieData();
    super.initState();
  }

  @override
  String getTitle() => "Pie Chart Half Pie";

  @override
  Widget getBody() {
    return Stack(
      children: <Widget>[
        Positioned(right: 0, left: 0, top: 0, bottom: 0, child: _initPieChart())
      ],
    );
  }

  // ignore: non_constant_identifier_names
  final List<String> PARTIES = ["Party A"
    ,"Party B"
    ,"Party C"
    ,"Party D"
    ,"Party E"
    ,"Party F"
    ,"Party G"
    ,"Party H"
    ,"Party I"
    ,"Party J"
    ,"Party K"
    ,"Party L"
    ,"Party M"
    ,"Party N"
    ,"Party O"
    ,"Party P"
    ,"Party Q"
    ,"Party R"
    ,"Party S"
    ,"Party T"
    ,"Party U"
    ,"Party V"
    ,"Party W"
    ,"Party X"
    ,"Party Y"
    ,"Party Z"];

  void _initController() {
    var desc = Description()..enabled = false;
    _controller = PieChartController(
        legendSettingFunction: (legend, controller) {
          _formatter.setPieChartPainter(controller as PieChartController);
          legend
            ..verticalAlignment = (LegendVerticalAlignment.top)
            ..horizontalAlignment = (LegendHorizontalAlignment.center)
            ..orientation = (LegendOrientation.horizontal)
            ..drawInside = (false)
            ..xEntrySpace = (7)
            ..yEntrySpace = (0)
            ..yOffset = (0);
        },
        rendererSettingFunction: (renderer) {
          (renderer as PieChartRenderer)
            ..setHoleColor(ColorUtils.white)
            ..setTransparentCircleColor(ColorUtils.white)
            ..setTransparentCircleAlpha(110)
            ..setEntryLabelColor(ColorUtils.white)
            ..setEntryLabelTextSize(12);
        },
        rotateEnabled: false,
        drawHole: true,
        usePercentValues: true,
        drawCenterText: true,
        highLightPerTapEnabled: true,
        maxAngle: 180,
        rawRotationAngle: 180,
        rotationAngle: 180,
        centerText: "half pie",
        centerTextOffsetX: 0,
        centerTextOffsetY: -20,
        centerTextTypeface: Util.LIGHT,
        entryLabelTypeface: Util.LIGHT,
        holeRadiusPercent: 58,
        transparentCircleRadiusPercent: 61,
        description: desc);
  }

  final PercentFormatter _formatter = PercentFormatter();

  void _initPieData() async {
    var img = await ImageLoader.loadImage('assets/img/star.png');
    var count = 4;
    var range = 100;

    List<PieEntry> values = [];

    for (int i = 0; i < count; i++) {
      values.add(PieEntry(
          icon: img,
          value: ((random.nextDouble() * range) + range / 5),
          label: PARTIES[i % PARTIES.length]));
    }

    PieDataSet dataSet = PieDataSet(values, "Election Results");
    dataSet.setSliceSpace(3);
    dataSet.setSelectionShift(5);

    dataSet.setColors1(ColorUtils.materialColors);
    //dataSet.setSelectionShift(0f);

    _controller.data = PieData(dataSet)
      ..setValueFormatter(PercentFormatter())
      ..setValueTextColor(ColorUtils.white)
      ..setValueTypeface(Util.LIGHT);

    setState(() {});
  }

  Widget _initPieChart() {
    var pieChart = PieChart(_controller);
    _controller.animator?.animateY2(1400, Easing.easeInOutQuad);
    return pieChart;
  }
}
