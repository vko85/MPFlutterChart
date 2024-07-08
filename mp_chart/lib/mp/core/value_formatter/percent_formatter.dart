import 'package:intl/intl.dart';
import 'package:mp_chart_x/mp/controller/pie_chart_controller.dart';
import 'package:mp_chart_x/mp/core/entry/pie_entry.dart';
import 'package:mp_chart_x/mp/core/value_formatter/value_formatter.dart';

class PercentFormatter extends ValueFormatter {
  late NumberFormat _format;
  late PieChartController _controller;
  late bool _percentSignSeparated;

  PercentFormatter() {
    _format = NumberFormat("###,###,##0.0");
    _percentSignSeparated = true;
  }

  setPieChartPainter(PieChartController controller) {
    _controller = controller;
  }

  @override
  String getFormattedValue1(double? value) {
    return _format.format(value) + (_percentSignSeparated ? " %" : "%");
  }

  @override
  String getPieLabel(double? value, PieEntry pieEntry) {
    if (_controller.painter != null &&
        _controller.painter!.isUsePercentValuesEnabled()) {
      // Converted to percent
      return getFormattedValue1(value);
    } else {
      // raw value, skip percent sign
      return _format.format(value);
    }
  }
}
