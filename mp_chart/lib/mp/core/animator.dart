import 'dart:async';
import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mp_chart_x/mp/core/common_interfaces.dart';

const double minAxis = 0.0;
const double maxAxis = 1.0;

abstract class Animator {
  /// object that is updated upon animation update
  AnimatorUpdateListener listener;

  /// The phase of drawn values on the y-axis. 0 - 1
  double phaseY = maxAxis;

  /// The phase of drawn values on the x-axis. 0 - 1
  double phaseX = maxAxis;

  double? angle;

  Animator(this.listener);

  void reset();

  void spin(int durationMillis, double fromAngle, double toAngle,
      EasingFunction easing);

  /// Animates values along the X axis, in a linear fashion.
  ///
  /// @param durationMillis animation duration
  void animateX1(int durationMillis) {
    animateX2(durationMillis, Easing.linear);
  }

  /// Animates values along the X axis.
  ///
  /// @param durationMillis animation duration
  /// @param easing EasingFunction
  void animateX2(int durationMillis, EasingFunction easing);

  /// Animates values along both the X and Y axes, in a linear fashion.
  ///
  /// @param durationMillisX animation duration along the X axis
  /// @param durationMillisY animation duration along the Y axis
  void animateXY1(int durationMillisX, int durationMillisY) {
    animateXY3(durationMillisX, durationMillisY, Easing.linear, Easing.linear);
  }

  /// Animates values along both the X and Y axes.
  ///
  /// @param durationMillisX animation duration along the X axis
  /// @param durationMillisY animation duration along the Y axis
  /// @param easing EasingFunction for both axes
  void animateXY2(
      int durationMillisX, int durationMillisY, EasingFunction easing);

  /// Animates values along both the X and Y axes.
  ///
  /// @param durationMillisX animation duration along the X axis
  /// @param durationMillisY animation duration along the Y axis
  /// @param easingX EasingFunction for the X axis
  /// @param easingY EasingFunction for the Y axis
  void animateXY3(int durationMillisX, int durationMillisY,
      EasingFunction easingX, EasingFunction easingY);

  /// Animates values along the Y axis, in a linear fashion.
  ///
  /// @param durationMillis animation duration
  void animateY1(int durationMillis) {
    animateY2(durationMillis, Easing.linear);
  }

  /// Animates values along the Y axis.
  ///
  /// @param durationMillis animation duration
  /// @param easing EasingFunction
  void animateY2(int durationMillis, EasingFunction easing);

  /// Gets the Y axis phase of the animation.
  ///
  /// @return double value of {@link #phaseY}
  double getPhaseY() {
    return phaseY;
  }

  /// Sets the Y axis phase of the animation.
  ///
  /// @param phase double value between 0 - 1
  void setPhaseY(double phase) {
    if (phase > maxAxis) {
      phase = maxAxis;
    } else if (phase < minAxis) {
      phase = minAxis;
    }
    phaseY = phase;
  }

  /// Gets the X axis phase of the animation.
  ///
  /// @return double value of {@link #phaseX}
  double getPhaseX() {
    return phaseX;
  }

  /// Sets the X axis phase of the animation.
  ///
  /// @param phase double value between 0 - 1
  void setPhaseX(double phase) {
    if (phase > maxAxis) {
      phase = maxAxis;
    } else if (phase < minAxis) {
      phase = minAxis;
    }
    phaseX = phase;
  }
}

class ChartAnimator extends Animator {
  static const int refreshRate = 16;

  Timer? _countdownTimer;

  bool _isShowed = false;

  ChartAnimator(AnimatorUpdateListener listener) : super(listener);

  @override
  void reset() {
    _isShowed = false;
  }

  bool get needReset => _isShowed;

  @override
  void spin(int durationMillis, double fromAngle, double toAngle,
      EasingFunction easing) {
    if (_isShowed ||
        _countdownTimer != null ||
        durationMillis < 0 ||
        fromAngle >= toAngle) {
      return;
    }
    reset();
    _isShowed = true;
    final double totalTime = durationMillis.toDouble();
    angle = fromAngle;
    _countdownTimer =
        Timer.periodic(const Duration(milliseconds: refreshRate), (timer) {
      if (durationMillis < 0) {
        angle = toAngle;
        _countdownTimer?.cancel();
        _countdownTimer = null;
      } else {
        angle = fromAngle +
            (toAngle - fromAngle) *
                (1.0 - easing.getInterpolation(durationMillis / totalTime));
        if (angle! >= toAngle) {
          angle = toAngle;
        }
        durationMillis -= refreshRate;
      }
      listener.onRotateUpdate(angle);
    });
  }

  @override
  void animateX2(int durationMillis, EasingFunction easing) {
    if (_isShowed || _countdownTimer != null || durationMillis < 0) {
      return;
    }
    reset();
    _isShowed = true;
    final double totalTime = durationMillis.toDouble();
    phaseX = minAxis;
    _countdownTimer =
        Timer.periodic(const Duration(milliseconds: refreshRate), (timer) {
      if (durationMillis < 0) {
        phaseX = maxAxis;
        _countdownTimer?.cancel();
        _countdownTimer = null;
      } else {
        phaseX = maxAxis - easing.getInterpolation(durationMillis / totalTime);
        if (phaseX >= maxAxis) {
          phaseX = maxAxis;
        }
        durationMillis -= refreshRate;
      }
      listener.onAnimationUpdate(phaseX, phaseY);
    });
  }

  @override
  void animateXY2(
      int durationMillisX, int durationMillisY, EasingFunction easing) {
    if (_isShowed ||
        _countdownTimer != null ||
        durationMillisX < 0 ||
        durationMillisY < 0) {
      return;
    }
    reset();
    _isShowed = true;
    final double totalTimeX = durationMillisX.toDouble();
    final double totalTimeY = durationMillisY.toDouble();
    phaseX = minAxis;
    phaseY = minAxis;
    _countdownTimer =
        Timer.periodic(const Duration(milliseconds: refreshRate), (timer) {
      if (durationMillisX < 0 && durationMillisY < 0) {
        phaseX = maxAxis;
        phaseY = maxAxis;
        _countdownTimer?.cancel();
        _countdownTimer = null;
      } else {
        phaseX = maxAxis - easing.getInterpolation(durationMillisX / totalTimeX);
        if (phaseX >= maxAxis) {
          phaseX = maxAxis;
        }

        phaseY = maxAxis - easing.getInterpolation(durationMillisY / totalTimeY);
        if (phaseY >= maxAxis) {
          phaseY = maxAxis;
        }

        durationMillisX -= refreshRate;
        durationMillisY -= refreshRate;
      }
      listener.onAnimationUpdate(phaseX, phaseY);
    });
  }

  @override
  void animateXY3(int durationMillisX, int durationMillisY,
      EasingFunction easingX, EasingFunction easingY) {
    if (_isShowed ||
        _countdownTimer != null ||
        durationMillisX < 0 ||
        durationMillisY < 0) {
      return;
    }
    reset();
    _isShowed = true;
    final double totalTimeX = durationMillisX.toDouble();
    final double totalTimeY = durationMillisY.toDouble();
    phaseX = minAxis;
    phaseY = minAxis;
    _countdownTimer =
        Timer.periodic(const Duration(milliseconds: refreshRate), (timer) {
      if (durationMillisX < 0 && durationMillisY < 0) {
        phaseX = maxAxis;
        phaseY = maxAxis;
        _countdownTimer?.cancel();
        _countdownTimer = null;
      } else {
        phaseX = maxAxis - easingX.getInterpolation(durationMillisX / totalTimeX);
        if (phaseX >= maxAxis) {
          phaseX = maxAxis;
        }

        phaseY = maxAxis - easingY.getInterpolation(durationMillisY / totalTimeY);
        if (phaseY >= maxAxis) {
          phaseY = maxAxis;
        }

        durationMillisX -= refreshRate;
        durationMillisY -= refreshRate;
      }
      listener.onAnimationUpdate(phaseX, phaseY);
    });
  }

  @override
  void animateY2(int durationMillis, EasingFunction easing) {
    if (_isShowed || _countdownTimer != null || durationMillis < 0) {
      return;
    }
    reset();
    _isShowed = true;
    final double totalTime = durationMillis.toDouble();
    phaseY = minAxis;
    _countdownTimer =
        Timer.periodic(const Duration(milliseconds: refreshRate), (timer) {
      if (durationMillis < 0) {
        phaseY = maxAxis;
        _countdownTimer?.cancel();
        _countdownTimer = null;
      } else {
        phaseY = maxAxis - easing.getInterpolation(durationMillis / totalTime);
        if (phaseY >= maxAxis) {
          phaseY = maxAxis;
        }
        durationMillis -= refreshRate;
      }
      listener.onAnimationUpdate(phaseX, phaseY);
    });
  }
}

class ChartAnimatorBySys extends Animator {
  static const int animateX = 0;
  static const int animateY = 1;
  static const int animateXY = 2;
  static const int animateSpin = 3;

  AnimationController? _controller;
  final ChartTickerProvider _provider = ChartTickerProvider();

  late EasingFunction easingFunction_1;
  EasingFunction? easingFunction_2;

  late double fromAngle;
  double? toAngle;

  late double durationMinPercent;
  late bool xDurationLong;

  bool animating = false;

  int which = -1;

  ChartAnimatorBySys(AnimatorUpdateListener listener) : super(listener) {
    _controller = AnimationController(vsync: _provider);

    _controller?.addListener(() {
      double percent = _controller!.value;
      switch (which) {
        case animateX:
          {
            phaseX = easingFunction_1.getInterpolation(percent);
            if (phaseX >= maxAxis) {
              phaseX = maxAxis;
            }
            this.listener.onAnimationUpdate(phaseX, phaseY);
          }
          break;
        case animateY:
          {
            phaseY = easingFunction_1.getInterpolation(percent);
            if (phaseY >= maxAxis) {
              phaseY = maxAxis;
            }
            this.listener.onAnimationUpdate(phaseX, phaseY);
          }
          break;
        case animateXY:
          {
            if (easingFunction_2 != null) {
              if (xDurationLong) {
                phaseX = easingFunction_1.getInterpolation(percent);
                var percentMin = percent / durationMinPercent;
                percentMin = percentMin > 1 ? 1 : percentMin;
                phaseY = easingFunction_2!.getInterpolation(percentMin);
              } else {
                phaseY = easingFunction_1.getInterpolation(percent);
                var percentMin = percent / durationMinPercent;
                percentMin = percentMin > 1 ? 1 : percentMin;
                phaseX = easingFunction_2!.getInterpolation(percentMin);
              }
            } else {
              if (xDurationLong) {
                phaseX = easingFunction_1.getInterpolation(percent);
                var percentMin = percent / durationMinPercent;
                percentMin = percentMin > 1 ? 1 : percentMin;
                phaseY = easingFunction_1.getInterpolation(percentMin);
              } else {
                phaseY = easingFunction_1.getInterpolation(percent);
                var percentMin = percent / durationMinPercent;
                percentMin = percentMin > 1 ? 1 : percentMin;
                phaseX = easingFunction_1.getInterpolation(percentMin);
              }
            }
            this.listener.onAnimationUpdate(phaseX, phaseY);
          }
          break;
        case animateSpin:
          {
            angle = fromAngle +
                (toAngle! - fromAngle) *
                    easingFunction_1.getInterpolation(percent);
            if (angle! >= toAngle!) {
              angle = toAngle;
            }
            this.listener.onRotateUpdate(angle);
          }
          break;
        default:
          break;
      }
    });
    _controller?.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          animating = false;
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.completed:
          animating = false;
          break;
      }
    });
  }

  @override
  void animateX2(int durationMillis, EasingFunction easing) {
    if (animating) return;
    animating = true;

    phaseX = minAxis;
    phaseY = maxAxis;
    _controller?.duration = Duration(milliseconds: durationMillis);
    which = animateX;
    easingFunction_1 = easing;
    easingFunction_2 = null;
    _controller?.forward();
  }

  @override
  void animateXY2(
      int durationMillisX, int durationMillisY, EasingFunction easing) {
    if (animating) return;
    animating = true;

    phaseX = minAxis;
    phaseY = minAxis;
    xDurationLong = durationMillisX > durationMillisY;
    durationMinPercent = xDurationLong
        ? durationMillisY / durationMillisX
        : durationMillisX / durationMillisY;
    _controller?.duration = Duration(
        milliseconds: xDurationLong ? durationMillisX : durationMillisY);
    easingFunction_1 = easing;
    easingFunction_2 = null;
    which = animateXY;
    _controller?.forward();
  }

  @override
  void animateXY3(int durationMillisX, int durationMillisY,
      EasingFunction easingX, EasingFunction easingY) {
    if (animating) return;
    animating = true;

    phaseX = minAxis;
    phaseY = minAxis;
    xDurationLong = durationMillisX > durationMillisY;
    durationMinPercent = xDurationLong
        ? durationMillisY / durationMillisX
        : durationMillisX / durationMillisY;
    _controller?.duration = Duration(
        milliseconds: xDurationLong ? durationMillisX : durationMillisY);
    easingFunction_1 = easingX;
    easingFunction_2 = easingY;
    which = animateXY;
    _controller?.forward();
  }

  @override
  void animateY2(int durationMillis, EasingFunction easing) {
    if (animating) return;
    animating = true;

    phaseX = maxAxis;
    phaseY = minAxis;
    _controller?.duration = Duration(milliseconds: durationMillis);
    easingFunction_1 = easing;
    easingFunction_2 = null;
    which = animateY;
    _controller?.forward();
  }

  @override
  void reset() {
    _controller?.reset();
  }

  @override
  void spin(int durationMillis, double fromAngle, double toAngle,
      EasingFunction easing) {
    if (animating || fromAngle >= toAngle) return;
    animating = true;

    this.fromAngle = fromAngle;
    angle = fromAngle;
    this.toAngle = toAngle;
    _controller?.duration = Duration(milliseconds: durationMillis);
    easingFunction_1 = easing;
    easingFunction_2 = null;
    which = animateSpin;
    _controller?.forward();
  }
}

class ChartTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(onTick) {
    return Ticker(onTick);
  }
}

mixin EasingFunction {
  /// Maps a value representing the elapsed fraction of an animation to a value that represents
  /// the interpolated fraction. This interpolated value is then multiplied by the change in
  /// value of an animation to derive the animated value at the current elapsed animation time.
  ///
  /// @param input A value between 0 and 1.0 indicating our current point
  ///        in the animation where 0 represents the start and 1.0 represents
  ///        the end
  /// @return The interpolation value. This value can be more than 1.0 for
  ///         interpolators which overshoot their targets, or less than 0 for
  ///         interpolators that undershoot their targets.
  double getInterpolation(double input);
}

const double doublePi = 2 * pi;

abstract class Easing {
  static const EasingFunction linear = LinearEasingFunction();
  static const EasingFunction easeInQuad = EaseInQuadEasingFunction();
  static const EasingFunction easeOutQuad = EaseOutQuadEasingFunction();
  static const EasingFunction easeInOutQuad = EaseInOutQuadEasingFunction();
  static const EasingFunction easeInCubic = EaseInCubicEasingFunction();
  static const EasingFunction easeOutCubic = EaseOutCubicEasingFunction();
  static const EasingFunction easeInOutCubic = EaseInOutCubicEasingFunction();
  static const EasingFunction easeInQuart = EaseInQuartEasingFunction();
  static const EasingFunction easeOutQuart = EaseOutQuartEasingFunction();
  static const EasingFunction easeInOutQuart = EaseInOutQuartEasingFunction();
  static const EasingFunction easeInSine = EaseInSineEasingFunction();
  static const EasingFunction easeOutSine = EaseOutSineEasingFunction();
  static const EasingFunction easeInOutSine = EaseInOutSineEasingFunction();
  static const EasingFunction easeInExpo = EaseInExpoEasingFunction();
  static const EasingFunction easeOutExpo = EaseOutExpoEasingFunction();
  static const EasingFunction easeInOutExpo = EaseInOutExpoEasingFunction();
  static const EasingFunction easeInCir = EaseInCircleEasingFunction();
  static const EasingFunction easeOutCir = EaseOutCircEasingFunction();
  static const EasingFunction easeInOutCir = EaseInOutCircEasingFunction();
  static const EasingFunction easeInElastic = EaseInElasticEasingFunction();
  static const EasingFunction easeOutElastic = EaseOutElasticEasingFunction();
  static const EasingFunction easeInOutElastic =
      EaseInOutElasticEasingFunction();
  static const EasingFunction easeInBack = EaseInBackEasingFunction();
  static const EasingFunction easeOutBack = EaseOutBackEasingFunction();
  static const EasingFunction easeInOutBack = EaseInOutBackEasingFunction();
  static const EasingFunction easeInBounce = EaseInBounceEasingFunction();
  static const EasingFunction easeOutBounce = EaseOutBounceEasingFunction();
  static const EasingFunction easeInOutBounce = EaseInOutBounceEasingFunction();
}

class EaseInOutBounceEasingFunction implements EasingFunction {
  const EaseInOutBounceEasingFunction();

  @override
  double getInterpolation(double input) {
    if (input < 0.5) {
      return Easing.easeInBounce.getInterpolation(input * 2) * 0.5;
    }
    return Easing.easeOutBounce.getInterpolation(input * 2 - 1) * 0.5 + 0.5;
  }
}

class EaseOutBounceEasingFunction implements EasingFunction {
  const EaseOutBounceEasingFunction();

  @override
  double getInterpolation(double input) {
    double s = 7.5625;
    if (input < (1 / 2.75)) {
      return s * input * input;
    } else if (input < (2 / 2.75)) {
      return s * (input -= (1.5 / 2.75)) * input + 0.75;
    } else if (input < (2.5 / 2.75)) {
      return s * (input -= (2.25 / 2.75)) * input + 0.9375;
    }
    return s * (input -= (2.625 / 2.75)) * input + 0.984375;
  }
}

class EaseInBounceEasingFunction implements EasingFunction {
  const EaseInBounceEasingFunction();

  @override
  double getInterpolation(double input) {
    return 1 - Easing.easeOutBounce.getInterpolation(1 - input);
  }
}

class EaseInOutBackEasingFunction implements EasingFunction {
  const EaseInOutBackEasingFunction();

  @override
  double getInterpolation(double input) {
    double s = 1.70158;
    input *= 2;
    if (input < 1) {
      return 0.5 * (input * input * (((s *= (1.525)) + 1) * input - s));
    }
    return 0.5 *
        ((input -= 2) * input * (((s *= (1.525)) + 1) * input + s) + 2);
  }
}

class EaseOutBackEasingFunction implements EasingFunction {
  const EaseOutBackEasingFunction();

  @override
  double getInterpolation(double input) {
    const double s = 1.70158;
    input--;
    return (input * input * ((s + 1) * input + s) + 1);
  }
}

class EaseInBackEasingFunction implements EasingFunction {
  const EaseInBackEasingFunction();

  @override
  double getInterpolation(double input) {
    const double s = 1.70158;
    return input * input * ((s + 1) * input - s);
  }
}

class EaseInOutElasticEasingFunction implements EasingFunction {
  const EaseInOutElasticEasingFunction();

  @override
  double getInterpolation(double input) {
    if (input == 0) {
      return 0;
    }

    input *= 2;
    if (input == 2) {
      return 1;
    }

    double p = 1 / 0.45;
    double s = 0.45 / doublePi * asin(1);
    if (input < 1) {
      return -0.5 *
          (pow(2, 10 * (input -= 1)) * sin((input * 1 - s) * doublePi * p));
    }
    return 1 +
        0.5 * pow(2, -10 * (input -= 1)) * sin((input * 1 - s) * doublePi * p);
  }
}

class EaseOutElasticEasingFunction implements EasingFunction {
  const EaseOutElasticEasingFunction();

  @override
  double getInterpolation(double input) {
    if (input == 0) {
      return 0;
    } else if (input == 1) {
      return 1;
    }

    double p = 0.3;
    double s = p / doublePi * asin(1);
    return 1 + pow(2, -10 * input) * sin((input - s) * doublePi / p);
  }
}

class EaseInElasticEasingFunction implements EasingFunction {
  const EaseInElasticEasingFunction();

  @override
  double getInterpolation(double input) {
    if (input == 0) {
      return 0;
    } else if (input == 1) {
      return 1;
    }

    double p = 0.3;
    double s = p / doublePi * asin(1);
    return -(pow(2, 10 * (input -= 1)) * sin((input - s) * doublePi / p));
  }
}

class EaseInOutCircEasingFunction implements EasingFunction {
  const EaseInOutCircEasingFunction();

  @override
  double getInterpolation(double input) {
    input *= 2;
    if (input < 1) {
      return -0.5 * (sqrt(1 - input * input) - 1);
    }
    return 0.5 * (sqrt(1 - (input -= 2) * input) + 1);
  }
}

class EaseOutCircEasingFunction implements EasingFunction {
  const EaseOutCircEasingFunction();

  @override
  double getInterpolation(double input) {
    input--;
    return sqrt(1 - input * input);
  }
}

class EaseInCircleEasingFunction implements EasingFunction {
  const EaseInCircleEasingFunction();

  @override
  double getInterpolation(double input) {
    return -(sqrt(1 - input * input) - 1);
  }
}

class EaseInOutExpoEasingFunction implements EasingFunction {
  const EaseInOutExpoEasingFunction();

  @override
  double getInterpolation(double input) {
    if (input == 0) {
      return 0;
    } else if (input == 1) {
      return 1;
    }

    input *= 2;
    if (input < 1) {
      return 0.5 * pow(2, 10 * (input - 1));
    }
    return 0.5 * (-pow(2, -10 * --input) + 2);
  }
}

class EaseOutExpoEasingFunction implements EasingFunction {
  const EaseOutExpoEasingFunction();

  @override
  double getInterpolation(double input) {
    return (input == 1) ? 1 : -pow(2, -10 * (input + 1)) as double;
  }
}

class EaseInExpoEasingFunction implements EasingFunction {
  const EaseInExpoEasingFunction();

  @override
  double getInterpolation(double input) {
    return (input == 0) ? 0 : pow(2, 10 * (input - 1)) as double;
  }
}

class EaseInOutSineEasingFunction implements EasingFunction {
  const EaseInOutSineEasingFunction();

  @override
  double getInterpolation(double input) {
    return -0.5 * (cos(pi * input) - 1.0);
  }
}

class EaseOutSineEasingFunction implements EasingFunction {
  const EaseOutSineEasingFunction();

  @override
  double getInterpolation(double input) {
    return sin(input * (pi / 2.0));
  }
}

class EaseInSineEasingFunction implements EasingFunction {
  const EaseInSineEasingFunction();

  @override
  double getInterpolation(double input) {
    return -cos(input * (pi / 2.0)) + 1.0;
  }
}

class EaseInOutQuartEasingFunction implements EasingFunction {
  const EaseInOutQuartEasingFunction();

  @override
  double getInterpolation(double input) {
    input *= 2.0;
    if (input < 1.0) {
      return 0.5 * pow(input, 4);
    }
    input -= 2.0;
    return -0.5 * (pow(input, 4) - 2.0);
  }
}

class EaseOutQuartEasingFunction implements EasingFunction {
  const EaseOutQuartEasingFunction();

  @override
  double getInterpolation(double input) {
    input--;
    return pow(input, 4) - 1.0;
  }
}

class EaseInQuartEasingFunction implements EasingFunction {
  const EaseInQuartEasingFunction();

  @override
  double getInterpolation(double input) {
    return pow(input, 4) as double;
  }
}

class EaseInOutCubicEasingFunction implements EasingFunction {
  const EaseInOutCubicEasingFunction();

  @override
  double getInterpolation(double input) {
    input *= 2.0;
    if (input < 1.0) {
      return 0.5 * pow(input, 3);
    }
    input -= 2.0;
    return 0.5 * (pow(input, 3) + 2.0);
  }
}

class EaseOutCubicEasingFunction implements EasingFunction {
  const EaseOutCubicEasingFunction();

  @override
  double getInterpolation(double input) {
    input--;
    return pow(input, 3) + 1.0;
  }
}

class EaseInCubicEasingFunction implements EasingFunction {
  const EaseInCubicEasingFunction();

  @override
  double getInterpolation(double input) {
    return pow(input, 3) as double;
  }
}

class EaseInOutQuadEasingFunction implements EasingFunction {
  const EaseInOutQuadEasingFunction();

  @override
  double getInterpolation(double input) {
    input *= 2.0;

    if (input < 1.0) {
      return 0.5 * input * input;
    }

    return -0.5 * ((--input) * (input - 2.0) - 1);
  }
}

class EaseOutQuadEasingFunction implements EasingFunction {
  const EaseOutQuadEasingFunction();

  @override
  double getInterpolation(double input) {
    return -input * (input - 2.0);
  }
}

class EaseInQuadEasingFunction implements EasingFunction {
  const EaseInQuadEasingFunction();

  @override
  double getInterpolation(double input) {
    return input * input;
  }
}

class LinearEasingFunction implements EasingFunction {
  const LinearEasingFunction();

  @override
  double getInterpolation(double input) {
    return input;
  }
}
