import 'dart:ui';

import 'package:mp_chart_x/mp/core/marker/line_chart_marker.dart';

import '../utils/color_utils.dart';

class BarChartMarker extends LineChartMarker {
  BarChartMarker(
      {Color textColor = ColorUtils.purple,
      Color backColor = ColorUtils.white,
      double? fontSize})
      : super(textColor: textColor, backColor: backColor, fontSize: fontSize);

  @override
  Offset calculatePos(double posX, double posY, double textW, double textH) {
    return Offset(posX - textW / 2, posY - textH * 2);
  }
}
