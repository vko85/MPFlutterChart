import 'package:flutter/widgets.dart';
import 'package:mp_chart_x/mp/chart/chart.dart';
import 'package:mp_chart_x/mp/controller/pie_radar_controller.dart';
import 'package:mp_chart_x/mp/core/highlight/highlight.dart';
import 'package:mp_chart_x/mp/core/pool/point.dart';
import 'package:mp_chart_x/mp/core/utils/highlight_utils.dart';
import 'package:mp_chart_x/mp/core/utils/utils.dart';
import 'package:gesture_detector_x/details.dart';

abstract class PieRadarChart<C extends PieRadarController> extends Chart<C> {
  const PieRadarChart(C controller, {Key? key}) : super(controller, key: key);
}

abstract class PieRadarChartState<T extends PieRadarChart>
    extends ChartState<T> {
  Highlight? lastHighlighted;
  final MPPointF _touchStartPoint = MPPointF.getInstance1(0, 0);
  double _startAngle = 0.0;

  void _setGestureStartAngle(double x, double y) {
    if (widget.controller.rotateEnabled) {
      _startAngle = widget.controller.painter!.getAngleForPoint(x, y) -
          widget.controller.painter!.getRawRotationAngle()!;
    }
  }

  void _updateGestureRotation(double x, double y) {
    if (widget.controller.rotateEnabled) {
      double angle =
          widget.controller.painter!.getAngleForPoint(x, y) - _startAngle;
      widget.controller.rawRotationAngle = angle;
      widget.controller.rotationAngle =
          Utils.getNormalizedAngle(widget.controller.rawRotationAngle!);
    }
  }

  @override
  void onTapDown(TapDownDetails details) {}

  @override
  void onSingleTapUp(TapUpDetails details) {
    if (widget.controller.painter!.highLightPerTapEnabled) {
      Highlight? h = widget.controller.painter!.getHighlightByTouchPoint(
          details.localPosition.dx, details.localPosition.dy);
      lastHighlighted = HighlightUtils.performHighlight(
          widget.controller.painter!, h, lastHighlighted);
      setStateIfNotDispose();
    } else {
      lastHighlighted = null;
    }
  }

  @override
  void onDoubleTapUp(TapUpDetails details) {}

  @override
  void onMoveStart(OpsMoveStartDetails details) {
    _setGestureStartAngle(details.localPoint.dx, details.localPoint.dy);
    _touchStartPoint
      ..x = details.localPoint.dx
      ..y = details.localPoint.dy;
  }

  @override
  void onMoveUpdate(OpsMoveUpdateDetails details) {
    _updateGestureRotation(details.localPoint.dx, details.localPoint.dy);
    setStateIfNotDispose();
  }

  @override
  void onMoveEnd(OpsMoveEndDetails details) {}

  @override
  void onScaleStart(OpsScaleStartDetails details) {
    _setGestureStartAngle(details.localPoint.dx, details.localPoint.dy);
    _touchStartPoint
      ..x = details.localPoint.dx
      ..y = details.localPoint.dy;
  }

  @override
  void onScaleUpdate(OpsScaleUpdateDetails details) {
    _updateGestureRotation(
        details.localFocalPoint.dx, details.localFocalPoint.dy);
    setStateIfNotDispose();
  }

  @override
  void onScaleEnd(OpsScaleEndDetails details) {}

  @override
  void onDragStart(LongPressStartDetails details) {}

  @override
  void onDragUpdate(LongPressMoveUpdateDetails details) {}

  @override
  void onDragEnd(LongPressEndDetails details) {}

  @override
  void updatePainter() {
    if (widget.controller.painter!.getData() != null &&
        widget.controller.painter!.getData()!.dataSets.isNotEmpty) {
      widget.controller.painter!.highlightValue6(lastHighlighted, false);
    }
  }
}
