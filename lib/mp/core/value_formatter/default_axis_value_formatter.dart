import 'package:intl/intl.dart';
import 'package:mp_chart_x/mp/core/value_formatter/value_formatter.dart';

class DefaultAxisValueFormatter extends ValueFormatter {
  /// decimalformat for formatting
  late NumberFormat _format;

  /// the number of decimal digits this formatter uses
  int? _digits;

  /// Constructor that specifies to how many digits the value should be
  /// formatted.
  ///
  /// @param digits
  DefaultAxisValueFormatter(int digits) {
    _digits = digits;

    StringBuffer b = StringBuffer();
    for (int i = 0; i < digits; i++) {
      if (i == 0) b.write(".");
      b.write("0");
    }

    _format = NumberFormat("###,###,###,##0$b");
  }

  @override
  String getFormattedValue1(double? value) {
    // avoid memory allocations here (for performance)
    return _format.format(value);
  }

  int? get digits => _digits;
}
