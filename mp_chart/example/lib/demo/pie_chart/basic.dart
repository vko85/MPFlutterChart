import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mp_chart_x/mp/chart/pie_chart.dart';
import 'package:mp_chart_x/mp/controller/pie_chart_controller.dart';
import 'package:mp_chart_x/mp/core/common_interfaces.dart';
import 'package:mp_chart_x/mp/core/data/pie_data.dart';
import 'package:mp_chart_x/mp/core/data_set/pie_data_set.dart';
import 'package:mp_chart_x/mp/core/description.dart';
import 'package:mp_chart_x/mp/core/entry/entry.dart';
import 'package:mp_chart_x/mp/core/entry/pie_entry.dart';
import 'package:mp_chart_x/mp/core/enums/legend_horizontal_alignment.dart';
import 'package:mp_chart_x/mp/core/enums/legend_orientation.dart';
import 'package:mp_chart_x/mp/core/enums/legend_vertical_alignment.dart';
import 'package:mp_chart_x/mp/core/highlight/highlight.dart';
import 'package:mp_chart_x/mp/core/image_loader.dart';
import 'package:mp_chart_x/mp/core/pool/point.dart';
import 'package:mp_chart_x/mp/core/render/pie_chart_renderer.dart';
import 'package:mp_chart_x/mp/core/utils/color_utils.dart';
import 'package:mp_chart_x/mp/core/value_formatter/percent_formatter.dart';
import 'package:example/demo/action_state.dart';
import 'package:example/demo/util.dart';

class PieChartBasic extends StatefulWidget {
  const PieChartBasic({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PieChartBasicState();
  }
}

class PieChartBasicState extends PieActionState<PieChartBasic>
    implements OnChartValueSelectedListener {
  final PercentFormatter _formatter = PercentFormatter();
  var random = Random(1);
  int _count = 4;
  double _range = 10.0;

  @override
  void initState() {
    _initController();
    _initPieData(_count, _range);
    super.initState();
  }

  @override
  String getTitle() => "Pie Chart Basic";

  @override
  Widget getBody() {
    return Stack(
      children: <Widget>[
        Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 100,
            child: PieChart(controller)),
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
                            max: 25,
                            onChanged: (value) {
                              _count = value.toInt();
                              _initPieData(_count, _range);
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
                            min: 0,
                            max: 200,
                            onChanged: (value) {
                              _range = value;
                              _initPieData(_count, _range);
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

  // ignore: non_constant_identifier_names
  final List<String> PARTIES = ["Party A", "Party B", "Party C", "Party D", "Party E", "Party F", "Party G","Party H"
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
    var desc = Description()
      ..text = "desc"
      ..enabled = true;
    controller = PieChartController(
        legendSettingFunction: (legend, controller) {
          _formatter.setPieChartPainter(controller as PieChartController);
          legend
            ..verticalAlignment = (LegendVerticalAlignment.top)
            ..horizontalAlignment = (LegendHorizontalAlignment.right)
            ..orientation = (LegendOrientation.vertical)
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
        drawCenterText: true,
        extraLeftOffset: 5,
        extraTopOffset: 10,
        extraRightOffset: 5,
        extraBottomOffset: 5,
        usePercentValues: true,
        centerText: _generateCenterSpannableText(),
        highLightPerTapEnabled: true,
        selectionListener: this,
        holeRadiusPercent: 58.0,
        transparentCircleRadiusPercent: 61,
        description: desc);
  }

  void _initPieData(int count, double range) async {
    var img = await ImageLoader.loadImage('assets/img/star.png');
    List<PieEntry> entries = [];

    // NOTE: The order of the entries when being added to the entries array determines their position around the center of
    // the chart.
    for (int i = 0; i < count; i++) {
      entries.add(PieEntry(
        value: ((random.nextDouble() * range) + range / 5),
        label: PARTIES[i % PARTIES.length],
        icon: img,
      ));
    }

    PieDataSet dataSet = PieDataSet(entries, "Election Results");

    dataSet.setDrawIcons(false);

    dataSet.setSliceSpace(3);
    dataSet.setIconsOffset(MPPointF(0, 40));
    dataSet.setSelectionShift(5);

    // add a lot of colors
    List<Color> colors = [];
    for (Color c in ColorUtils.vordiplomColors) {
      colors.add(c);
    }
    for (Color c in ColorUtils.joyfulColors) {
      colors.add(c);
    }
    for (Color c in ColorUtils.colorfulColors) {
      colors.add(c);
    }
    for (Color c in ColorUtils.libertyColors) {
      colors.add(c);
    }
    for (Color c in ColorUtils.pastelColors) {
      colors.add(c);
    }
    colors.add(ColorUtils.holoBlue);
    dataSet.setColors1(colors);

    controller.data = PieData(dataSet);
    controller.data
      ?..setValueFormatter(_formatter)
      ..setValueTextSize(11)
      ..setValueTextColor(ColorUtils.white)
      ..setValueTypeface(Util.LIGHT);

    setState(() {});
  }

  @override
  void onNothingSelected() {}

  @override
  void onValueSelected(Entry? e, Highlight? h) {}

  String _generateCenterSpannableText() {
    return "basic pie chart";
  }
}
