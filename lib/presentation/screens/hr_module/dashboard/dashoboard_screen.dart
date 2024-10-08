import 'package:flutter/material.dart';

import '../../../../../app/resources/value_manager.dart';

///prachi
class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Container(child:Image.asset('images/HRDASHBOARD.png',fit: BoxFit.cover,))),
    );
  }
}
