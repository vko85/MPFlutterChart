import 'dart:ui';

import 'package:mp_chart_x/mp/core/data_interfaces/i_scatter_data_set.dart';
import 'package:mp_chart_x/mp/core/render/i_shape_renderer.dart';
import 'package:mp_chart_x/mp/core/utils/color_utils.dart';
import 'package:mp_chart_x/mp/core/view_port.dart';
import 'package:mp_chart_x/mp/core/utils/utils.dart';

class CircleShapeRenderer implements IShapeRenderer {
  @override
  void renderShape(
      Canvas c,
      IScatterDataSet dataSet,
      ViewPortHandler? viewPortHandler,
      double? posX,
      double? posY,
      Paint? renderPaint) {
    final double shapeSize = dataSet.getScatterShapeSize();
    final double shapeHalf = shapeSize / 2;
    final double shapeHoleSizeHalf =
        Utils.convertDpToPixel(dataSet.getScatterShapeHoleRadius());
    final double shapeHoleSize = shapeHoleSizeHalf * 2.0;
    final double shapeStrokeSize = (shapeSize - shapeHoleSize) / 2.0;
    final double shapeStrokeSizeHalf = shapeStrokeSize / 2.0;

    final Color shapeHoleColor = dataSet.getScatterShapeHoleColor();

    if (shapeSize > 0.0) {
      renderPaint
        ?..style = PaintingStyle.stroke
        ..strokeWidth = shapeStrokeSize;

      c.drawCircle(Offset(posX!, posY!),
          shapeHoleSizeHalf + shapeStrokeSizeHalf, renderPaint!);

      if (shapeHoleColor != ColorUtils.colorNone) {
        renderPaint
          ..style = PaintingStyle.fill
          ..color = shapeHoleColor;

        c.drawCircle(Offset(posX, posY), shapeHoleSizeHalf, renderPaint);
      }
    } else {
      renderPaint!.style = PaintingStyle.fill;

      c.drawCircle(Offset(posX!, posY!), shapeHalf, renderPaint);
    }
  }
}
