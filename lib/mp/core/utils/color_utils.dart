import 'package:flutter/painting.dart';

abstract class ColorUtils {
  // ignore: non_constant_identifier_names
  static const Color blue = Color(0xFF0000FF);

  // ignore: non_constant_identifier_names
  static const Color colorSkip = Color(0x00112234);

  // ignore: non_constant_identifier_names
  static const Color colorNone = Color(0x00112233);

  // ignore: non_constant_identifier_names
  static const Color dkGray = Color(0xFF444444);

  // ignore: non_constant_identifier_names
  static const Color gray = Color(0xFF999999);

  // ignore: non_constant_identifier_names
  static const Color yellow = Color(0xFFFFFF00);

  // ignore: non_constant_identifier_names
  static const Color black = Color(0xFF000000);

  // ignore: non_constant_identifier_names
  static const Color ltGray = Color(0xFFCCCCCC);

  // ignore: non_constant_identifier_names
  static const Color red = fadeRedEnd;

  // ignore: non_constant_identifier_names
  static const Color holoBlue = Color.fromARGB(255, 51, 181, 229);

  // ignore: non_constant_identifier_names
  static const Color white = Color(0xFFffffff);

  // ignore: non_constant_identifier_names
  static const Color purple = Color(0xFF512DA8);

  // ignore: non_constant_identifier_names
  static const Color fadeRedStart = Color(0x00FF0000);

  // ignore: non_constant_identifier_names
  static const Color fadeRedEnd = Color(0xFFFF0000);

// ignore: non_constant_identifier_names
  static const Color holoOrangeLight = Color(0xffffbb33);

  // ignore: non_constant_identifier_names
  static const Color holoBlueLight = Color(0xff33b5e5);

  // ignore: non_constant_identifier_names
  static const Color holoGreenLight = Color(0xff99cc00);

  // ignore: non_constant_identifier_names
  static const Color holoRedLight = Color(0xffff4444);

  // ignore: non_constant_identifier_names
  static const Color holoBlueDark = Color(0xff0099cc);

  // ignore: non_constant_identifier_names
  static const Color holoPurple = Color(0xffaa66cc);

  // ignore: non_constant_identifier_names
  static const Color holoGreenDark = Color(0xff669900);

  // ignore: non_constant_identifier_names
  static const Color holoRedDark = Color(0xffcc0000);

  // ignore: non_constant_identifier_names
  static const Color holoOrangeDark = Color(0xffff8800);

// ignore: non_constant_identifier_names
  static final List<Color> vordiplomColors = List.empty(growable: true)
    ..add(const Color.fromARGB(255, 192, 255, 140))
    ..add(const Color.fromARGB(255, 255, 247, 140))
    ..add(const Color.fromARGB(255, 255, 208, 140))
    ..add(const Color.fromARGB(255, 140, 234, 255))
    ..add(const Color.fromARGB(255, 255, 140, 157));

// ignore: non_constant_identifier_names
  static final List<Color> joyfulColors = List.empty(growable: true)
    ..add(const Color.fromARGB(255, 217, 80, 138))
    ..add(const Color.fromARGB(255, 254, 149, 7))
    ..add(const Color.fromARGB(255, 254, 247, 120))
    ..add(const Color.fromARGB(255, 106, 167, 134))
    ..add(const Color.fromARGB(255, 53, 194, 209));

// ignore: non_constant_identifier_names
  static final List<Color> materialColors = List.empty(growable: true)
    ..add(const Color(0xFF2ecc71))
    ..add(const Color(0xFFf1c40f))
    ..add(const Color(0xFFe74c3c))
    ..add(const Color(0xFF3498db));

// ignore: non_constant_identifier_names
  static final List<Color> colorfulColors = List.empty(growable: true)
    ..add(const Color.fromARGB(255, 193, 37, 82))
    ..add(const Color.fromARGB(255, 255, 102, 0))
    ..add(const Color.fromARGB(255, 245, 199, 0))
    ..add(const Color.fromARGB(255, 106, 150, 31))
    ..add(const Color.fromARGB(255, 179, 100, 53));

// ignore: non_constant_identifier_names
  static final List<Color> libertyColors = List.empty(growable: true)
    ..add(const Color.fromARGB(255, 207, 248, 246))
    ..add(const Color.fromARGB(255, 148, 212, 212))
    ..add(const Color.fromARGB(255, 136, 180, 187))
    ..add(const Color.fromARGB(255, 118, 174, 175))
    ..add(const Color.fromARGB(255, 42, 109, 130));

// ignore: non_constant_identifier_names
  static final List<Color> pastelColors = List.empty(growable: true)
    ..add(const Color.fromARGB(255, 64, 89, 128))
    ..add(const Color.fromARGB(255, 149, 165, 124))
    ..add(const Color.fromARGB(255, 217, 184, 162))
    ..add(const Color.fromARGB(255, 191, 134, 134))
    ..add(const Color.fromARGB(255, 179, 48, 80));

  static Color colorWithAlpha(Color strokeColor, int alpha) {
    return Color.fromARGB(
        alpha, strokeColor.red, strokeColor.green, strokeColor.blue);
  }

  static Color getHoloBlue() {
    return const Color.fromARGB(255, 51, 181, 229);
  }
}
