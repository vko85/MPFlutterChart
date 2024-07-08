import 'package:intl/intl.dart';
import 'package:mp_chart_x/mp/core/entry/bar_entry.dart';
import 'package:mp_chart_x/mp/core/value_formatter/value_formatter.dart';

class StackedValueFormatter extends ValueFormatter {
  /// if true, all stack values of the stacked bar entry are drawn, else only top
  late bool _drawWholeStack;

  /// a string that should be appended behind the value
  late String _suffix;

  late NumberFormat _format;

  /// Constructor.
  ///
  /// @param drawWholeStack if true, all stack values of the stacked bar entry are drawn, else only top
  /// @param suffix         a string that should be appended behind the value
  /// @param decimals       the number of decimal digits to use
  StackedValueFormatter(bool drawWholeStack, String suffix, int decimals) {
    _drawWholeStack = drawWholeStack;
    _suffix = suffix;

    StringBuffer b = StringBuffer();
    for (int i = 0; i < decimals; i++) {
      if (i == 0) b.write(".");
      b.write("0");
    }

    _format = NumberFormat("###,###,###,##0$b");
  }

  @override
  String getBarStackedLabel(double value, BarEntry stackedEntry) {
    if (!_drawWholeStack) {
      List<double>? vals = stackedEntry.yVals;

      if (vals != null) {
        // find out if we are on top of the stack
        if (vals[vals.length - 1] == value) {
          // return the "sum" across all stack values
          return _format.format(stackedEntry.y) + _suffix;
        } else {
          return ""; // return empty
        }
      }
    }
    // return the "proposed" value
    return _format.format(value) + _suffix;
  }
}
