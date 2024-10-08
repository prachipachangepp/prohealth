import 'package:flutter/material.dart';

class WrapWidget extends StatefulWidget {
  final List<Widget> childern;
  WrapWidget({super.key, required this.childern});

  @override
  State<WrapWidget> createState() => _WrapWidgetState();
}

class _WrapWidgetState extends State<WrapWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.symmetric(
    horizontal: MediaQuery.of(context).size.width/100,
    vertical: MediaQuery.of(context).size.height/120),
    child: Container(
      height: MediaQuery.of(context).size.height/1,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: widget.childern,
      ),
    ),);
  }
}
