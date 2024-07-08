import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/responsive_screen.dart';
import 'package:prohealth/presentation/widgets/screen_frame/screen_frame_mobile.dart';
import 'package:prohealth/presentation/widgets/screen_frame/screen_frame_tab.dart';
import 'package:prohealth/presentation/widgets/screen_frame/screen_frame_web.dart';

class ScreenFrame extends StatelessWidget {
  const ScreenFrame({super.key, required this.appBar});
  final Widget appBar;
  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: const ScreenFrameMobile(),
        web: ScreenFrameWeb(
          appBar: appBar,
        ),
        tablet: const ScreenFrameTab());
  }
}
