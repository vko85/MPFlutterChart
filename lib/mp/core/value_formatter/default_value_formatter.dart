import 'package:intl/intl.dart';
import 'package:mp_chart_x/mp/core/value_formatter/value_formatter.dart';

class DefaultValueFormatter extends ValueFormatter {
  /// DecimalFormat for formatting
  late NumberFormat _format;

  int? _decimalDigits;

  /// Constructor that specifies to how many digits the value should be
  /// formatted.
  ///
  /// @param digits
  DefaultValueFormatter(int digits) {
    setup(digits);
  }

  /// Sets up the formatter with a given number of decimal digits.
  ///
  /// @param digits
  void setup(int digits) {
    _decimalDigits = digits;

    if (digits < 1) {
      digits = 1;
    }

    StringBuffer b = StringBuffer();
    b.write(".");
    for (int i = 0; i < digits; i++) {
      b.write("0");
    }
    _format = NumberFormat("###,###,###,##0$b");
  }

  @override
  String getFormattedValue1(double? value) {
    // put more logic here ...
    // avoid memory allocations here (for performance reasons)

    return _format.format(value);
  }

  @override
  String toString() {
    return _format.toString();
  }

  int? get decimalDigits => _decimalDigits;
}
