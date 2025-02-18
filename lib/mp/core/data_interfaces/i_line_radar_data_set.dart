import 'dart:ui';

import 'package:mp_chart_x/mp/core/data_interfaces/i_line_scatter_candle_radar_data_set.dart';
import 'package:mp_chart_x/mp/core/entry/entry.dart';

mixin ILineRadarDataSet<T extends Entry>
    implements ILineScatterCandleRadarDataSet<T> {
  /// Returns the color that is used for filling the line surface area.
  ///
  /// @return
  Color getFillColor();

  /// Returns the drawable used for filling the area below the line.
  ///
  /// @return
//  Drawable getFillDrawable(); todo

  /// Returns the alpha value that is used for filling the line surface,
  /// default: 85
  ///
  /// @return
  int getFillAlpha();

  /// Returns the stroke-width of the drawn line
  ///
  /// @return
  double? getLineWidth();

  /// Returns true if filled drawing is enabled, false if not
  ///
  /// @return
  bool isDrawFilledEnabled();

  /// Set to true if the DataSet should be drawn filled (surface), and not just
  /// as a line, disabling this will give great performance boost. Please note that this method
  /// uses the canvas.clipPath(...) method for drawing the filled area.
  /// For devices with API level < 18 (Android 4.3), hardware acceleration of the chart should
  /// be turned off. Default: false
  ///
  /// @param enabled
  void setDrawFilled(bool enabled);

  bool isGradientEnabled();

  void setGradientFilled(bool enabled);
}
