import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = Color(0xff4B89BA);
  static Color blueprime = Color(0xff50B5E5);
  static Color blueiconColor = Color(0xff4FB8EB);
  static Color bluelight = Color(0xFF579EBA);
  static Color bluebottom = Color(0xFF1696C8);
  static Color bluecontainer = Color(0xff9BADCA);
  static Color cream = Color(0xffD9D9D9);
  ///static Color grey = Color(0xff8B8781);
  static Color grey = Color(0xff8B8781);
  static Color mediumgrey = Color(0xFF686464);
  static Color darkgrey = Color(0xFF565656);
  static Color faintOrange = Color(0xffF6928A);
  static Color greenF = Color(0xff52A889);
  static Color green = Color(0xffB4DB4C);
  static Color orange = Color(0xffF2451C);
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color black = Color(0xff000000);
  static Color blackfaint = Color(0xFF333333);
  static Color whitesheed = Color(0xffACA5BB);
  static Color whitebluecolor = Color(0xffB1D6F4);
  static Color red = Color(0xffD93D3D);
  static Color rednew = Color(0xffEB3223);
  static Color buttoncolor = Color(0xfc79AEF5);
  static Color lightgreyheading = Color(0xff575757);

  static Color transparentColor = Color(0x808B8781);
  static Color navyblue = HexColor.fromHex('#004181');
  static Color faintgrey = HexColor.fromHex('#8B8781');
  static Color faintblueweb = HexColor.fromHex('#3A74B4');
  static Color faintgreybg = HexColor.fromHex('#f5f5f5');
  static Color sidebarcolor = HexColor.fromHex('d3dde8');
  static Color appbarcolor = HexColor.fromHex('#1E56A0');
  static Color buttongridecolor = HexColor.fromHex('#D6E4F0');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF' + hexColorString; //8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
