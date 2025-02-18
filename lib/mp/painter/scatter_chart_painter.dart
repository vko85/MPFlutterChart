import 'package:flutter/cupertino.dart';
import 'package:mp_chart_x/mp/core/animator.dart';
import 'package:mp_chart_x/mp/core/axis/x_axis.dart';
import 'package:mp_chart_x/mp/core/axis/y_axis.dart';
import 'package:mp_chart_x/mp/core/common_interfaces.dart';
import 'package:mp_chart_x/mp/core/data/scatter_data.dart';
import 'package:mp_chart_x/mp/core/data_provider/scatter_data_provider.dart';
import 'package:mp_chart_x/mp/core/description.dart';
import 'package:mp_chart_x/mp/core/functions.dart';
import 'package:mp_chart_x/mp/core/legend/legend.dart';
import 'package:mp_chart_x/mp/core/marker/i_marker.dart';
import 'package:mp_chart_x/mp/core/render/legend_renderer.dart';
import 'package:mp_chart_x/mp/core/render/scatter_chart_renderer.dart';
import 'package:mp_chart_x/mp/core/render/x_axis_renderer.dart';
import 'package:mp_chart_x/mp/core/render/y_axis_renderer.dart';
import 'package:mp_chart_x/mp/core/chart_trans_listener.dart';
import 'package:mp_chart_x/mp/core/transformer/transformer.dart';
import 'package:mp_chart_x/mp/core/view_port.dart';
import 'package:mp_chart_x/mp/painter/bar_line_chart_painter.dart';

class ScatterChartPainter extends BarLineChartBasePainter<ScatterData?>
    implements ScatterDataProvider {
  ScatterChartPainter(
      ScatterData? data,
      Animator? animator,
      ViewPortHandler? viewPortHandler,
      double? maxHighlightDistance,
      bool highLightPerTapEnabled,
      double extraLeftOffset,
      double extraTopOffset,
      double extraRightOffset,
      double extraBottomOffset,
      IMarker? marker,
      Description? desc,
      bool drawMarkers,
      Color? infoBgColor,
      TextPainter? infoPainter,
      TextPainter? descPainter,
      XAxis? xAxis,
      Legend? legend,
      LegendRenderer? legendRenderer,
      DataRendererSettingFunction? rendererSettingFunction,
      OnChartValueSelectedListener? selectedListener,
      int maxVisibleCount,
      bool autoScaleMinMaxEnabled,
      bool pinchZoomEnabled,
      bool doubleTapToZoomEnabled,
      bool highlightPerDragEnabled,
      bool dragXEnabled,
      bool dragYEnabled,
      bool scaleXEnabled,
      bool scaleYEnabled,
      Paint? gridBackgroundPaint,
      Paint? backgroundPaint,
      Paint? borderPaint,
      bool drawGridBackground,
      bool drawBorders,
      bool clipValuesToContent,
      double minOffset,
      bool keepPositionOnRotation,
      OnDrawListener? drawListener,
      YAxis? axisLeft,
      YAxis? axisRight,
      YAxisRenderer? axisRendererLeft,
      YAxisRenderer? axisRendererRight,
      Transformer? leftAxisTransformer,
      Transformer? rightAxisTransformer,
      XAxisRenderer? xAxisRenderer,
      Matrix4? zoomMatrixBuffer,
      bool customViewPortEnabled,
      ChartTransListener? chartTransListener)
      : super(
            data,
            animator,
            viewPortHandler,
            maxHighlightDistance,
            highLightPerTapEnabled,
            extraLeftOffset,
            extraTopOffset,
            extraRightOffset,
            extraBottomOffset,
            marker,
            desc,
            drawMarkers,
            infoBgColor,
            infoPainter,
            descPainter,
            xAxis,
            legend,
            legendRenderer,
            rendererSettingFunction,
            selectedListener,
            maxVisibleCount,
            autoScaleMinMaxEnabled,
            pinchZoomEnabled,
            doubleTapToZoomEnabled,
            highlightPerDragEnabled,
            dragXEnabled,
            dragYEnabled,
            scaleXEnabled,
            scaleYEnabled,
            gridBackgroundPaint,
            borderPaint,
            drawGridBackground,
            drawBorders,
            clipValuesToContent,
            minOffset,
            keepPositionOnRotation,
            drawListener,
            axisLeft,
            axisRight,
            axisRendererLeft,
            axisRendererRight,
            leftAxisTransformer,
            rightAxisTransformer,
            xAxisRenderer,
            zoomMatrixBuffer,
            customViewPortEnabled,
            backgroundPaint,
            chartTransListener);

  @override
  void initDefaultWithData() {
    super.initDefaultWithData();
    renderer = ScatterChartRenderer(this, animator, viewPortHandler);
    xAxis?.spaceMin = (0.5);
    xAxis?.spaceMax = (0.5);
  }

  @override
  ScatterData? getScatterData() {
    return getData() as ScatterData?;
  }
}
