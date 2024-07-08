import 'package:mp_chart_x/mp/core/highlight/highlight.dart';

mixin IHighlighter {
  Highlight? getHighlight(double x, double y);
}
