import 'package:mp_chart_x/mp/core/entry/entry.dart';
import 'dart:ui' as ui;

class BubbleEntry extends Entry {
  /// size value
  double _size = 0;

  /// Constructor.
  ///
  /// @param x The value on the x-axis.
  /// @param y The value on the y-axis.
  /// @param size The size of the bubble.
  BubbleEntry(
      {required double x,
      required double y,
      double size=0,
      Object? data,
      ui.Image? icon})
      : super(x: x, y: y, data: data, icon: icon) {
    _size = size;
  }

  @override
  BubbleEntry copy() {
    BubbleEntry c = BubbleEntry(x: x, y: y, size: _size, data: mData);
    return c;
  }

  // ignore: unnecessary_getters_setters
  double get size => _size;

  // ignore: unnecessary_getters_setters
  set size(double value) {
    _size = value;
  }
}
