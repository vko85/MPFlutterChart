import 'dart:ui';

import 'package:mp_chart_x/mp/core/marker/line_chart_marker.dart';

import '../utils/color_utils.dart';

class HorizontalBarChartMarker extends LineChartMarker {
  HorizontalBarChartMarker(
      {Color textColor = ColorUtils.purple,
      Color backColor = ColorUtils.white,
      double? fontSize})
      : super(textColor: textColor, backColor: backColor, fontSize: fontSize);
}
