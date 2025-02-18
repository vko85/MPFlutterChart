import 'package:intl/intl.dart';
import 'package:mp_chart_x/mp/core/axis/axis_base.dart';
import 'package:mp_chart_x/mp/core/axis/x_axis.dart';
import 'package:mp_chart_x/mp/core/value_formatter/value_formatter.dart';

class MyValueFormatter extends ValueFormatter {
  late NumberFormat _format;
  late String _suffix;

  MyValueFormatter(String suffix) {
    _format = NumberFormat("###,###,###,##0.0");
    _suffix = suffix;
  }

  @override
  String getFormattedValue1(double? value) {
    return _format.format(value) + _suffix;
  }

  @override
  String getAxisLabel(double? value, AxisBase? axis) {
    if (axis is XAxis) {
      return _format.format(value);
    } else if (value! > 0) {
      return _format.format(value) + _suffix;
    } else {
      return _format.format(value);
    }
  }
}
