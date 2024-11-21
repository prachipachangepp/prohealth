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
  static Color granitegray= Color(0xff686464);

  static Color burnt_red= Color(0xffDE0909);

  static Color containerBorderGrey = Color(0xffB1B1B1);
  static Color textPrimaryColor = Color(0xff686464);
  static Color fmediumgrey = Color(0xFF686464).withOpacity(0.46);
  static Color mediumgrey = Color(0xFF686464);
  static Color faintGrey = Color(0xFFC1C1C1);
  static Color whiteGrey = Color(0xFFF0F0F0);
  static Color darkgrey = Color(0xFF565656);
  static Color faintOrange = Color(0xffF6928A);
  static Color EfaintOrange = Color(0xffF6928A).withOpacity(0.5);
  static Color sfaintOrange = Color(0xffE8A87D);
  static Color greenDark = Color(0xff008000);
  static Color greenF = Color(0xff52A889);
  static Color redSign = Color(0xffBA0707);
  static Color green = Color(0xffB4DB4C);
  static Color tangerine = Color(0xffFEBD4D);
  static Color orange = Color(0xffF2451C);
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color black = Color(0xff000000);
  static Color textBlack = Color(0xff2A2827);
  static Color blackForLoginTexts = Color(0xff000000).withOpacity(0.5);
  static Color blackfaint = Color(0xFF333333);
  static Color whitesheed = Color(0xffACA5BB);
  static Color whitebluecolor = Color(0xffE0F2F1);
  static Color red = Color(0xffD93D3D);
  static Color rednew = Color(0xffEB3223);
  static Color buttoncolor = Color(0xfc79AEF5);
  //static Color greylight = Color(0xff575757);
  static Color dividerColor = Color(0xffD4D4D4);
  static Color darkgray = Color(0xff454545);

  static Color transparentColor = Color(0x808B8781);
  static Color navyblue = HexColor.fromHex('#004181');
  static Color faintgrey = HexColor.fromHex('#8B8781');
  static Color faintblueweb = HexColor.fromHex('#3A74B4');
  static Color faintgreybg = HexColor.fromHex('#f5f5f5');
  static Color sidebarcolor = HexColor.fromHex('d3dde8');
  static Color appbarcolor = HexColor.fromHex('#1E56A0');
  static Color buttongridecolor = HexColor.fromHex('#D6E4F0');

  ///Dashboard Hr
  static Color ContainerBorder = Color(0xFFDEEBFD);
  static Color purpleBlack = Color(0xFF7886A9);
  static Color pink = Color(0xFFEE61CF);
  static Color blueDash = Color(0xff3786F1);
  static Color incidentBlue = Color(0xff344BFD);
  static Color incidentskin = Color(0xffF4A79D);


  static Color skini = Color(0xFFFFA8A8);
  static Color purple = Color(0xFFC0FE233).withOpacity(0.2);
  static Color barChartBlue = Color(0xFFCBFFFF);
  static Color pieChartGreen = Color(0xFFBAEDBD);
  static Color pieChartBBlue = Color(0xFF527FB9);
  static Color pieChartBlue = Color(0xFF95A4FC);
  static Color pieChartpurple = Color(0xFFAFB7FF);
  static Color pieChartFpurple = Color(0xFFDFE2FF);
  static Color pieChartYellow = Color(0xFFD2F55C);
  static Color pieChartFYellow = Color(0xFFEBF9BB);
  static Color pieChartNBlue = Color(0xFF59A9F4);
  static Color dashBlueHead = Color(0xFFDCF0FA);
  static Color dashBlueHeadBottom = Color(0xFF1EA0F1);
  static Color dashListviewData = Color(0xFF718EBF);
  static Color dashListviewDataPink = Color(0xFFFFE0EB);
  static Color dashDivider = Color(0xFFE9E9E9);
  ///emp tenure doc
  static Color emptenure = Color(0xFF579EBA);
  static Color empdoc = Color(0xFF16DBCC);
  ///output relative to input
  static Color relativeResult = Color(0xFFCBFFFF);

  ///dashboard EM
  static Color tabbarText = Color(0xFF008ABD);
  static Color blueBorder = Color(0xFF2EA2D4);
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

class IconColorManager{
  static Color red = Color(0xffD93D3D);
  static Color bluebottom = Color(0xFF1696C8);
  static Color white = Color(0xffFFFFFF);
}

