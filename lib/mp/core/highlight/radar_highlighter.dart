import 'package:mp_chart_x/mp/core/data_interfaces/i_data_set.dart';
import 'package:mp_chart_x/mp/core/entry/entry.dart';
import 'package:mp_chart_x/mp/core/highlight/highlight.dart';
import 'package:mp_chart_x/mp/core/highlight/pie_radar_highlighter.dart';
import 'package:mp_chart_x/mp/painter/radar_chart_painter.dart';
import 'package:mp_chart_x/mp/core/pool/point.dart';
import 'package:mp_chart_x/mp/core/utils/utils.dart';

class RadarHighlighter extends PieRadarHighlighter<RadarChartPainter> {
  RadarHighlighter(RadarChartPainter chart) : super(chart);

  @override
  Highlight? getClosestHighlight(int index, double x, double y) {
    List<Highlight> highlights = getHighlightsAtIndex(index);

    double distanceToCenter =
        painter!.distanceToCenter(x, y) / painter!.getFactor();

    Highlight? closest;
    double distance = double.infinity;

    for (int i = 0; i < highlights.length; i++) {
      Highlight high = highlights[i];

      double cdistance = (high.y! - distanceToCenter).abs();
      if (cdistance < distance) {
        closest = high;
        distance = cdistance;
      }
    }

    return closest;
  }

  /// Returns an array of Highlight objects for the given index. The Highlight
  /// objects give information about the value at the selected index and the
  /// DataSet it belongs to. INFORMATION: This method does calculations at
  /// runtime. Do not over-use in performance critical situations.
  ///
  /// @param index
  /// @return
  List<Highlight> getHighlightsAtIndex(int index) {
    highlightBuffer.clear();

    double phaseX = painter!.animator!.getPhaseX();
    double phaseY = painter!.animator!.getPhaseY();
    double sliceAngle = painter!.getSliceAngle();
    double factor = painter!.getFactor();

    MPPointF pOut = MPPointF.getInstance1(0, 0);
    for (int i = 0; i < painter!.getData()!.getDataSetCount(); i++) {
      IDataSet? dataSet = painter?.getData()?.getDataSetByIndex(i);

      if (dataSet == null) continue;

      final Entry entry = dataSet.getEntryForIndex(index)!;

      double y = (entry.y - painter!.getYChartMin()!);

      Utils.getPosition(painter!.getCenterOffsets(), y * factor * phaseY,
          sliceAngle * index * phaseX + painter!.getRotationAngle(), pOut);

      highlightBuffer.add(Highlight(
          x: index.toDouble(),
          y: entry.y,
          xPx: pOut.x,
          yPx: pOut.y,
          dataSetIndex: i,
          axis: dataSet.getAxisDependency()));
    }

    return highlightBuffer;
  }
}
