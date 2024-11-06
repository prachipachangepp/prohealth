import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/value_manager.dart';

class WrapWidget extends StatefulWidget {
  final List<Widget> children;
  WrapWidget({super.key, required this.children});

  @override
  State<WrapWidget> createState() => _WrapWidgetState();
}

class _WrapWidgetState extends State<WrapWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p10,
      ),
      child: Container(
      //  height: MediaQuery.of(context).size.height,
        alignment: Alignment.topLeft,
        child: Wrap(
          alignment: widget.children.length == 1
              ? WrapAlignment.start
              : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: widget.children,
        ),
      ),
    );
  }
}

