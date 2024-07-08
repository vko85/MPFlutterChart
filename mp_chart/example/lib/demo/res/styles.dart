import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'dimens.dart';

class TextStyles {
  static const TextStyle textMain12 = TextStyle(
    fontSize: Dimens.sp12,
    color: Colours.appMain,
  );
  static const TextStyle textMain14 = TextStyle(
    fontSize: Dimens.sp14,
    color: Colours.appMain,
  );
  static const TextStyle textNormal12 = TextStyle(
    fontSize: Dimens.sp12,
    color: Colours.textNormal,
  );
  static const TextStyle textDark12 = TextStyle(
    fontSize: Dimens.sp12,
    color: Colours.textDark,
  );
  static const TextStyle textDark14 = TextStyle(
    fontSize: Dimens.sp14,
    color: Colours.textDark,
  );
  static const TextStyle textDark16 = TextStyle(
    fontSize: Dimens.sp16,
    color: Colours.textDark,
  );
  static const TextStyle textBoldDark14 = TextStyle(
      fontSize: Dimens.sp14,
      color: Colours.textDark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark16 = TextStyle(
      fontSize: Dimens.sp16,
      color: Colours.textDark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark18 = TextStyle(
    fontSize: Dimens.sp18,
    color: Colours.textDark,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark24 = TextStyle(
      fontSize: 24.0,
      color: Colours.textDark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBoldDark26 = TextStyle(
      fontSize: 26.0,
      color: Colours.textDark,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textGray10 = TextStyle(
    fontSize: Dimens.sp10,
    color: Colours.textGray,
  );
  static const TextStyle textGray12 = TextStyle(
    fontSize: Dimens.sp12,
    color: Colours.textGray,
  );
  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.sp14,
    color: Colours.textGray,
  );
  static const TextStyle textGray16 = TextStyle(
    fontSize: Dimens.sp16,
    color: Colours.textGray,
  );
  static const TextStyle textGrayC12 = TextStyle(
    fontSize: Dimens.sp12,
    color: Colours.textGrayC,
  );
  static const TextStyle textGrayC14 = TextStyle(
    fontSize: Dimens.sp14,
    color: Colours.textGrayC,
  );
}

/// 间隔
class Gaps {
  /// 水平间隔
  static const Widget hGap5 = SizedBox(width: Dimens.dp5);
  static const Widget hGap10 = SizedBox(width: Dimens.dp10);
  static const Widget hGap15 = SizedBox(width: Dimens.dp15);
  static const Widget hGap16 = SizedBox(width: Dimens.dp16);
  /// 垂直间隔
  static const Widget vGap5 = SizedBox(height: Dimens.dp5);
  static const Widget vGap10 = SizedBox(height: Dimens.dp10);
  static const Widget vGap15 = SizedBox(height: Dimens.dp15);
  static const Widget vGap50 = SizedBox(height: Dimens.dp50);

  static const Widget vGap4 = SizedBox(height: 4.0);
  static const Widget vGap8 = SizedBox(height: 8.0);
  static const Widget vGap12 = SizedBox(height: 12.0);
  static const Widget vGap16 = SizedBox(height: Dimens.dp16);

  static const Widget hGap4 = SizedBox(width: 4.0);
  static const Widget hGap8 = SizedBox(width: 8.0);
  static const Widget hGap12 = SizedBox(width: 12.0);
  
  static Widget line = Container(height: 0.6, color: Colours.line);
  static const Widget empty = SizedBox();
}
