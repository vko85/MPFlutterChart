import 'package:mp_chart_x/mp/core/entry/entry.dart';
import 'dart:ui' as ui;

import 'package:mp_chart_x/mp/core/utils/color_utils.dart';
import 'package:mp_chart_x/mp/core/utils/utils.dart';

class PieEntry extends Entry {
  String? _label;
  double? _labelTextSize;
  ui.Color? _labelColor;

  PieEntry(
      {required double value,
      String? label,
      ui.Image? icon,
      Object? data,
      double? labelTextSize,
      ui.Color? labelColor})
      : super(x: 0, y: value, icon: icon, data: data) {
    _label = label;
    _labelTextSize = labelTextSize ?? Utils.convertDpToPixel(10);
    _labelColor = labelColor ?? ColorUtils.white;
  }

  double getValue() {
    return y;
  }

  @override
  PieEntry copy() {
    PieEntry e = PieEntry(value: getValue(), label: _label, data: mData);
    return e;
  }

  // ignore: unnecessary_getters_setters
  String? get label => _label;

  double? get labelTextSize => _labelTextSize;

  ui.Color? get labelColor => _labelColor;

  // ignore: unnecessary_getters_setters
  set label(String? value) {
    _label = value;
  }
}
