import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = Color(0xff4B89BA);
  static Color blueprime = Color(0xff50B5E5);
  static Color blueiconColor = Color(0xff4FB8EB);
  static Color bluelight = Color(0xFF579EBA);
  static Color bluebottom = Color(0xFF1696C8);
  static Color bluecontainer = Color(0xff9BADCA);
  static Color cream = Color(0xffD9D9D9);
  static Color pinkfaint = Color(0xffF69DF6);
  static Color greylight = Color(0xff575757);
  static Color calandercolour = Color(0xff50B5E5);

  ///static Color grey = Color(0xff8B8781);
  static Color grey = Color(0xff8B8781);
  static Color charcoal = Color(0xff454545);
  static Color darkblue = Color(0xff271E4A);
  static Color orangeheading = Color(0xffFFA500);
  static Color lightGrey = Color(0xffB7B7B7);
  static Color containerBorderGrey = Color(0xffB1B1B1);
  static Color textPrimaryColor = Color(0xff686464);
  static Color fmediumgrey = Color(0xFF686464).withOpacity(0.46);
  static Color mediumgrey = Color(0xFF686464);
  static Color faintGrey = Color(0xFFC1C1C1);
  static Color whiteGrey = Color(0xFFF0F0F0);
  static Color darkgrey = Color(0xFF565656);
  static Color faintOrange = Color(0xffF6928A);
  static Color sfaintOrange = Color(0xffE8A87D);
  static Color greenDark = Color(0xff008000);
  static Color greenF = Color(0xff52A889);
  static Color green = Color(0xffB4DB4C);
  static Color orange = Color(0xffF2451C);
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color black = Color(0xff000000);
  static Color textBlack = Color(0xff2A2827);
  static Color blackForLoginTexts = Color(0xff000000).withOpacity(0.5);
  static Color blackfaint = Color(0xFF333333);
  static Color whitesheed = Color(0xffACA5BB);
  static Color whitebluecolor = Color(0xffB1D6F4);
  static Color red = Color(0xffD93D3D);
  static Color rednew = Color(0xffEB3223);
  static Color buttoncolor = Color(0xfc79AEF5);
  static Color lightgreyheading = Color(0xff575757);
  static Color dividerColor = Color(0xffD4D4D4);

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
