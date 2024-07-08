import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:mp_chart_x/mp/controller/controller.dart';
import 'package:gesture_detector_x/details.dart';
import 'package:gesture_detector_x/gesture_detector_x.dart';

abstract class Chart<C extends Controller> extends StatefulWidget {
  final C controller;

  @override
  State<StatefulWidget> createState() {
    return controller.createChartState();
  }

  const Chart(this.controller, {Key? key}) : super(key: key);
}

abstract class ChartState<T extends Chart> extends State<T> {

  bool isCapturing = false;

  void setStateIfNotDispose() {
    if (mounted) {
      setState(() {});
    }
  }

  void updatePainter();

  Future<Uint8List?> capture() async {
    // if (!isCapturing) {
    //   isCapturing = true;
    //   Uint8List? imgFile;
    //   try {
    //     imgFile = await _screenshotController.capture(pixelRatio: 3.0);
    //     isCapturing = false;
    //   } catch (e) {
    //     isCapturing = false;
    //   }
    //   return imgFile;
    // }
    return null;
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller.animator = oldWidget.controller.animator;
    widget.controller.state = this;
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.doneBeforePainterInit();
    widget.controller.initialPainter();
    updatePainter();
    return  Stack(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            children: [
              ConstrainedBox(
                  constraints: const BoxConstraints(
                      minHeight: double.infinity, minWidth: double.infinity),
                  child: GestureDetectorX(
                      tapDown: (details) {
                        onTapDown(details);
                      },
                      singleTapUp: (details) {
                        onSingleTapUp(details);
                      },
                      doubleTapUp: (details) {
                        onDoubleTapUp(details);
                      },
                      moveStart: (details) {
                        onMoveStart(details);
                      },
                      moveUpdate: (details) {
                        onMoveUpdate(details);
                      },
                      moveEnd: (details) {
                        onMoveEnd(details);
                      },
                      scaleStart: (details) {
                        onScaleStart(details);
                      },
                      scaleUpdate: (details) {
                        onScaleUpdate(details);
                      },
                      scaleEnd: (details) {
                        onScaleEnd(details);
                      },
                      dragStart: (details) {
                        onDragStart(details);
                      },
                      dragUpdate: (details) {
                        onDragUpdate(details);
                      },
                      dragEnd: (details) {
                        onDragEnd(details);
                      },
                      needHorizontalConflictFunc:
                          widget.controller.horizontalConflictResolveFunc,
                      needVerticalConflictFunc:
                          widget.controller.verticalConflictResolveFunc,
                      child: CustomPaint(painter: widget.controller.painter))),
            ]);
  }

  @override
  void reassemble() {
    super.reassemble();
    widget.controller.animator?.reset();
    widget.controller.painter?.reassemble();
  }

  void onTapDown(TapDownDetails details);

  void onSingleTapUp(TapUpDetails details);

  void onDoubleTapUp(TapUpDetails details);

  void onMoveStart(OpsMoveStartDetails details);

  void onMoveUpdate(OpsMoveUpdateDetails details);

  void onMoveEnd(OpsMoveEndDetails details);

  void onScaleStart(OpsScaleStartDetails details);

  void onScaleUpdate(OpsScaleUpdateDetails details);

  void onScaleEnd(OpsScaleEndDetails details);

  void onDragStart(LongPressStartDetails details);

  void onDragUpdate(LongPressMoveUpdateDetails details);

  void onDragEnd(LongPressEndDetails details);
}
