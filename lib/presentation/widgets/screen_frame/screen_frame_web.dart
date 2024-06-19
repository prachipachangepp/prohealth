import 'package:flutter/material.dart';

class ScreenFrameWeb extends StatelessWidget {
  const ScreenFrameWeb({super.key, required this.appBar});
  final Widget appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              appBar,
              Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
